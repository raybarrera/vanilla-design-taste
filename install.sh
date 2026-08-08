#!/usr/bin/env bash
# Install vanilla-design-taste skills into the user-level agents skills directory.
#
# Follows the cross-client Agent Skills convention (agentskills.io):
#
#   ~/.agents/skills/<skill-name>/SKILL.md
#   ~/.agents/skills/<skill-name>/references/   # optional per-skill docs
#
# Each skill directory is self-contained (SKILL.md + its own references/).
# This matches how harnesses discover skills: scan ~/.agents/skills/*/SKILL.md
#
# Usage:
#   ./install.sh                 # install/update into ~/.agents/skills
#   ./install.sh --dir PATH      # custom skills directory
#   ./install.sh --uninstall     # remove skills installed by this script
#   ./install.sh --dry-run       # print actions only
#   ./install.sh --force         # replace existing skills not owned by this pack
set -euo pipefail

PACK_NAME="vanilla-design-taste"
MANAGED_MARKER=".vanilla-design-taste-managed"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILLS_DIR="${SCRIPT_DIR}/skills"

# agentskills.io cross-client user scope: ~/.agents/skills
# Optional override: AGENTS_SKILLS_DIR (full path to the skills directory)
SKILLS_DIR="${AGENTS_SKILLS_DIR:-${HOME}/.agents/skills}"
MODE="install"
DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Install vanilla-design-taste into a user-level Agent Skills directory.

Default destination (agentskills.io cross-client convention):

  ~/.agents/skills/<skill-name>/

Usage:
  ./install.sh [options]

Options:
  --dir PATH       Skills directory (default: $AGENTS_SKILLS_DIR or ~/.agents/skills)
  --uninstall      Remove skills previously installed by this script
  --force          Replace skill names not marked as managed by this pack
  --dry-run        Show what would happen without writing
  -h, --help       Show this help

Environment:
  AGENTS_SKILLS_DIR   Override default skills directory (same as --dir)
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
      SKILLS_DIR="$2"
      shift 2
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

SKILLS_DIR="${SKILLS_DIR/#\~/${HOME}}"
if [[ "$SKILLS_DIR" != /* ]]; then
  SKILLS_DIR="$(pwd)/${SKILLS_DIR}"
fi

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

is_managed_entry() {
  local entry="$1"
  [[ -e "${entry}/${MANAGED_MARKER}" || -L "${entry}/${MANAGED_MARKER}" ]]
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

sync_skill() {
  local src="$1"
  local dest="$2"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: sync ${src}/ → ${dest}/"
    return 0
  fi
  mkdir -p "$dest"
  if command -v rsync >/dev/null 2>&1; then
    # Do not delete the managed marker if we write it after; --delete is fine
    # because we rewrite the marker after sync.
    rsync -a --delete \
      --exclude "${MANAGED_MARKER}" \
      "${src}/" "${dest}/"
  else
    rm -rf "$dest"
    mkdir -p "$(dirname "$dest")"
    cp -a "$src" "$dest"
  fi
}

write_marker() {
  local dest="$1"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: write ${dest}/${MANAGED_MARKER}"
    return 0
  fi
  {
    printf 'pack=%s\n' "$PACK_NAME"
    printf 'source=%s\n' "$SCRIPT_DIR"
    printf 'installed_at=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  } >"${dest}/${MANAGED_MARKER}"
}

uninstall_skills() {
  log "Uninstalling ${PACK_NAME} from ${SKILLS_DIR}"

  local names=()
  local name entry
  while IFS= read -r name; do
    [[ -n "$name" ]] || continue
    names+=("$name")
  done < <(list_skill_names "$SOURCE_SKILLS_DIR" 2>/dev/null || true)

  if [[ ! -d "$SKILLS_DIR" ]]; then
    log "  skills directory not present: ${SKILLS_DIR}"
    log "Done."
    return 0
  fi

  for name in "${names[@]+"${names[@]}"}"; do
    entry="${SKILLS_DIR}/${name}"
    if [[ -e "$entry" || -L "$entry" ]]; then
      if is_managed_entry "$entry"; then
        log "  remove: ${entry}"
        remove_path "$entry"
      else
        log "  skip (not managed by this pack): ${entry}"
      fi
    fi
  done

  log "Done."
}

install_skills() {
  [[ -d "$SOURCE_SKILLS_DIR" ]] || die "skills/ not found next to install.sh (${SOURCE_SKILLS_DIR})"

  local skill_names=()
  local name
  while IFS= read -r name; do
    [[ -n "$name" ]] || continue
    skill_names+=("$name")
  done < <(list_skill_names "$SOURCE_SKILLS_DIR")

  [[ ${#skill_names[@]} -gt 0 ]] || die "no skills with SKILL.md found under ${SOURCE_SKILLS_DIR}"

  log "Installing ${PACK_NAME} → ${SKILLS_DIR}"
  log "  skills: ${skill_names[*]}"

  for name in "${skill_names[@]}"; do
    local entry="${SKILLS_DIR}/${name}"
    if [[ -e "$entry" || -L "$entry" ]]; then
      if is_managed_entry "$entry"; then
        continue
      fi
      if [[ "$FORCE" -eq 1 ]]; then
        log "  will replace conflicting skill: ${entry}"
      else
        die "skill name already exists and is not managed by this pack: ${entry}
  re-run with --force to replace, or remove it manually"
      fi
    fi
  done

  ensure_dir "$SKILLS_DIR"

  for name in "${skill_names[@]}"; do
    local src="${SOURCE_SKILLS_DIR}/${name}"
    local dest="${SKILLS_DIR}/${name}"
    log "  install ${name}"
    if [[ -e "$dest" || -L "$dest" ]]; then
      if is_managed_entry "$dest" || [[ "$FORCE" -eq 1 ]]; then
        remove_path "$dest"
      else
        die "refusing to overwrite unmanaged skill: ${dest}"
      fi
    fi
    sync_skill "$src" "$dest"
    write_marker "$dest"
  done

  log "Done."
  log ""
  log "Skills directory: ${SKILLS_DIR}"
  log "Each skill is a self-contained agentskills.io directory (SKILL.md + references/)."
  log "Re-run ./install.sh after pulling updates."
}

if [[ "$MODE" == "uninstall" ]]; then
  uninstall_skills
  exit 0
fi

install_skills
