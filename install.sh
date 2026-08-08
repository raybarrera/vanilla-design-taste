#!/usr/bin/env bash
# Install vanilla-design-taste skills into a global .agents directory.
#
# Default layout (relative links in skills keep working):
#
#   ~/.agents/
#     packs/vanilla-design-taste/   # full pack (skills, references, attribution)
#     skills/<name> -> ../packs/vanilla-design-taste/skills/<name>
#
# Usage:
#   ./install.sh                 # install/update into ~/.agents
#   ./install.sh --dir PATH      # custom agents root
#   ./install.sh --copy          # copy skill trees instead of symlinking
#   ./install.sh --uninstall     # remove this pack and its skill links
#   ./install.sh --dry-run       # print actions only
#   ./install.sh --force         # replace existing skill entries that are not ours
set -euo pipefail

PACK_NAME="vanilla-design-taste"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILLS_DIR="${SCRIPT_DIR}/skills"
SOURCE_REFS_DIR="${SCRIPT_DIR}/references"

AGENTS_DIR="${AGENTS_HOME:-${HOME}/.agents}"
MODE="install"
LINK_MODE="symlink"
DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Install vanilla-design-taste into a global .agents tree.

Usage:
  ./install.sh [options]

Options:
  --dir PATH       Agents root (default: $AGENTS_HOME or ~/.agents)
  --copy           Copy skill directories instead of symlinking into packs/
  --uninstall      Remove pack files and skill entries installed by this script
  --force          Replace conflicting skill names not owned by this pack
  --dry-run        Show what would happen without writing
  -h, --help       Show this help

Environment:
  AGENTS_HOME      Override default agents root (same as --dir)
EOF
}

log() { printf '%s\n' "$*"; }

die() {
  echo "error: $*" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir)
      [[ $# -ge 2 ]] || die "--dir needs a path"
      AGENTS_DIR="$2"
      shift 2
      ;;
    --copy)
      LINK_MODE="copy"
      shift
      ;;
    --uninstall)
      MODE="uninstall"
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

AGENTS_DIR="${AGENTS_DIR/#\~/${HOME}}"
if [[ "$AGENTS_DIR" != /* ]]; then
  AGENTS_DIR="$(pwd)/${AGENTS_DIR}"
fi

PACK_DIR="${AGENTS_DIR}/packs/${PACK_NAME}"
SKILLS_DIR="${AGENTS_DIR}/skills"
MARKER_FILE="${PACK_DIR}/.install-source"

list_skill_names() {
  local dir="$1"
  [[ -d "$dir" ]] || return 0
  local path name
  for path in "$dir"/*; do
    [[ -e "$path" || -L "$path" ]] || continue
    [[ -d "$path" ]] || continue
    name="$(basename "$path")"
    [[ -f "${path}/SKILL.md" ]] || continue
    printf '%s\n' "$name"
  done | sort
}

is_our_skill_entry() {
  local entry="$1"
  local target

  if [[ -L "$entry" ]]; then
    target="$(readlink "$entry" || true)"
    [[ "$target" == *"/packs/${PACK_NAME}/skills/"* ]] && return 0
    [[ "$target" == *"packs/${PACK_NAME}/skills/"* ]] && return 0
    return 1
  fi

  if [[ -d "$entry" && -f "${entry}/.vanilla-design-taste-managed" ]]; then
    return 0
  fi

  return 1
}

remove_path() {
  local path="$1"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: rm -rf ${path}"
    return 0
  fi
  rm -rf "$path"
}

ensure_dir() {
  local path="$1"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: mkdir -p ${path}"
    return 0
  fi
  mkdir -p "$path"
}

sync_tree() {
  local src="$1"
  local dest="$2"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: sync ${src}/ → ${dest}/"
    return 0
  fi
  mkdir -p "$dest"
  if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete "${src}/" "${dest}/"
  else
    rm -rf "$dest"
    mkdir -p "$(dirname "$dest")"
    cp -a "$src" "$dest"
  fi
}

uninstall_pack() {
  log "Uninstalling ${PACK_NAME} from ${AGENTS_DIR}"

  local names=()
  local name entry
  while IFS= read -r name; do
    [[ -n "$name" ]] || continue
    names+=("$name")
  done < <({
    list_skill_names "${PACK_DIR}/skills" 2>/dev/null || true
    list_skill_names "$SOURCE_SKILLS_DIR" 2>/dev/null || true
  } | sort -u)

  if [[ -d "$SKILLS_DIR" || -L "$SKILLS_DIR" ]]; then
    for name in "${names[@]+"${names[@]}"}"; do
      entry="${SKILLS_DIR}/${name}"
      if [[ -e "$entry" || -L "$entry" ]]; then
        if is_our_skill_entry "$entry"; then
          log "  remove skill entry: ${entry}"
          remove_path "$entry"
        else
          log "  skip skill entry (not ours): ${entry}"
        fi
      fi
    done
  fi

  if [[ -e "$PACK_DIR" || -L "$PACK_DIR" ]]; then
    log "  remove pack: ${PACK_DIR}"
    remove_path "$PACK_DIR"
  else
    log "  pack not present: ${PACK_DIR}"
  fi

  log "Done."
}

install_pack() {
  [[ -d "$SOURCE_SKILLS_DIR" ]] || die "skills/ not found next to install.sh (${SOURCE_SKILLS_DIR})"

  local skill_names=()
  local name
  while IFS= read -r name; do
    [[ -n "$name" ]] || continue
    skill_names+=("$name")
  done < <(list_skill_names "$SOURCE_SKILLS_DIR")

  [[ ${#skill_names[@]} -gt 0 ]] || die "no skills with SKILL.md found under ${SOURCE_SKILLS_DIR}"

  log "Installing ${PACK_NAME} → ${AGENTS_DIR}"
  log "  mode: ${LINK_MODE}"
  log "  skills: ${skill_names[*]}"

  for name in "${skill_names[@]}"; do
    local entry="${SKILLS_DIR}/${name}"
    if [[ -e "$entry" || -L "$entry" ]]; then
      if is_our_skill_entry "$entry"; then
        continue
      fi
      if [[ "$FORCE" -eq 1 ]]; then
        log "  replace conflicting skill: ${entry}"
        remove_path "$entry"
      else
        die "skill name already exists and is not managed by this pack: ${entry}
  re-run with --force to replace, or remove it manually"
      fi
    fi
  done

  ensure_dir "$SKILLS_DIR"
  ensure_dir "$PACK_DIR"
  ensure_dir "${PACK_DIR}/skills"

  sync_tree "$SOURCE_SKILLS_DIR" "${PACK_DIR}/skills"
  if [[ -d "$SOURCE_REFS_DIR" ]]; then
    sync_tree "$SOURCE_REFS_DIR" "${PACK_DIR}/references"
  fi

  if [[ "$DRY_RUN" -eq 0 ]]; then
    for f in README.md ATTRIBUTION.md LICENSE; do
      if [[ -f "${SCRIPT_DIR}/${f}" ]]; then
        cp -a "${SCRIPT_DIR}/${f}" "${PACK_DIR}/${f}"
      fi
    done
    {
      printf 'source=%s\n' "$SCRIPT_DIR"
      printf 'installed_at=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
      printf 'link_mode=%s\n' "$LINK_MODE"
    } >"$MARKER_FILE"
  else
    log "DRY-RUN: write ${MARKER_FILE}"
  fi

  for name in "${skill_names[@]}"; do
    local entry="${SKILLS_DIR}/${name}"
    local pack_skill="${PACK_DIR}/skills/${name}"

    if [[ -e "$entry" || -L "$entry" ]]; then
      remove_path "$entry"
    fi

    if [[ "$LINK_MODE" == "symlink" ]]; then
      local rel_target="../packs/${PACK_NAME}/skills/${name}"
      log "  link ${entry} → ${rel_target}"
      if [[ "$DRY_RUN" -eq 0 ]]; then
        ln -s "$rel_target" "$entry"
      fi
    else
      log "  copy ${pack_skill} → ${entry}"
      if [[ "$DRY_RUN" -eq 0 ]]; then
        cp -a "$pack_skill" "$entry"
        touch "${entry}/.vanilla-design-taste-managed"
        # From ~/.agents/skills/<name>, ../../references → ~/.agents/references
        mkdir -p "${AGENTS_DIR}/references"
        if command -v rsync >/dev/null 2>&1; then
          rsync -a "${PACK_DIR}/references/" "${AGENTS_DIR}/references/"
        else
          cp -a "${PACK_DIR}/references/." "${AGENTS_DIR}/references/"
        fi
        if [[ -f "${PACK_DIR}/ATTRIBUTION.md" ]]; then
          cp -a "${PACK_DIR}/ATTRIBUTION.md" "${AGENTS_DIR}/ATTRIBUTION.md"
        fi
      fi
    fi
  done

  log "Done."
  log ""
  log "Skills available under: ${SKILLS_DIR}"
  log "Pack files:             ${PACK_DIR}"
  if [[ "$LINK_MODE" == "symlink" ]]; then
    log "Skill entries are symlinks into the pack (re-run ./install.sh to update)."
  else
    log "Skill entries are copies (re-run ./install.sh --copy to refresh)."
  fi
}

if [[ "$MODE" == "uninstall" ]]; then
  uninstall_pack
  exit 0
fi

install_pack
