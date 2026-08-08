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
# Local:
#   ./install.sh
#
# Remote one-liner (curl is the common form):
#   curl -fsSL https://raw.githubusercontent.com/raybarrera/vanilla-design-taste/master/install.sh | bash
#
# With flags when piped:
#   curl -fsSL …/install.sh | bash -s -- --force
set -euo pipefail

PACK_NAME="vanilla-design-taste"
MANAGED_MARKER=".vanilla-design-taste-managed"
REPO_URL="${VDT_REPO_URL:-https://github.com/raybarrera/vanilla-design-taste.git}"
REPO_REF="${VDT_REF:-master}"

# Resolve script location. When piped via curl|bash, BASH_SOURCE may be /dev/fd/*
# or similar and skills/ will not sit next to the script — we clone instead.
SOURCE_ROOT=""
SOURCE_SKILLS_DIR=""
CLONE_DIR=""
CLEANUP_CLONE=0

if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "bash" && "${BASH_SOURCE[0]}" != "-" ]]; then
  _src="${BASH_SOURCE[0]}"
  if [[ -f "$_src" ]]; then
    SOURCE_ROOT="$(cd "$(dirname "$_src")" && pwd)"
  fi
fi

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

  # Remote (no clone required):
  curl -fsSL https://raw.githubusercontent.com/raybarrera/vanilla-design-taste/master/install.sh | bash
  curl -fsSL …/install.sh | bash -s -- --force

Options:
  --dir PATH       Skills directory (default: $AGENTS_SKILLS_DIR or ~/.agents/skills)
  --ref REF        Git ref to fetch when installing remotely (default: master, or $VDT_REF)
  --uninstall      Remove skills previously installed by this script
  --force          Replace skill names not marked as managed by this pack
  --dry-run        Show what would happen without writing
  -h, --help       Show this help

Environment:
  AGENTS_SKILLS_DIR   Override default skills directory (same as --dir)
  VDT_REF             Default git ref for remote install (same as --ref)
  VDT_REPO_URL        Override git remote (default: github.com/raybarrera/vanilla-design-taste.git)
EOF
}

log() { printf '%s\n' "$*"; }

die() {
  echo "error: $*" >&2
  exit 1
}

cleanup() {
  if [[ "$CLEANUP_CLONE" -eq 1 && -n "$CLONE_DIR" && -d "$CLONE_DIR" ]]; then
    rm -rf "$CLONE_DIR"
  fi
}
trap cleanup EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir)
      [[ $# -ge 2 ]] || die "--dir needs a path"
      SKILLS_DIR="$2"
      shift 2
      ;;
    --ref)
      [[ $# -ge 2 ]] || die "--ref needs a git ref"
      REPO_REF="$2"
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

resolve_source() {
  if [[ -n "$SOURCE_ROOT" && -d "${SOURCE_ROOT}/skills" ]]; then
    SOURCE_SKILLS_DIR="${SOURCE_ROOT}/skills"
    log "Using local skills: ${SOURCE_SKILLS_DIR}"
    return 0
  fi

  command -v git >/dev/null 2>&1 || die "git is required for remote install"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "DRY-RUN: would git clone --depth 1 --branch ${REPO_REF} ${REPO_URL}"
    # Still need a real tree for dry-run skill listing if possible — clone for accuracy
  fi

  CLONE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/vdt-install.XXXXXX")"
  CLEANUP_CLONE=1
  log "Fetching ${REPO_URL} @ ${REPO_REF}"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    # Clone anyway so dry-run can list skills; temp dir is removed on exit
    :
  fi
  git clone --depth 1 --branch "$REPO_REF" "$REPO_URL" "$CLONE_DIR/repo" >/dev/null 2>&1 \
    || die "failed to clone ${REPO_URL} (ref ${REPO_REF})"
  SOURCE_ROOT="${CLONE_DIR}/repo"
  SOURCE_SKILLS_DIR="${SOURCE_ROOT}/skills"
  [[ -d "$SOURCE_SKILLS_DIR" ]] || die "clone missing skills/: ${SOURCE_SKILLS_DIR}"
  log "Using fetched skills: ${SOURCE_SKILLS_DIR}"
}

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
    printf 'source=%s\n' "${SOURCE_ROOT:-remote}"
    printf 'ref=%s\n' "$REPO_REF"
    printf 'installed_at=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  } >"${dest}/${MANAGED_MARKER}"
}

uninstall_skills() {
  resolve_source

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
  resolve_source
  [[ -d "$SOURCE_SKILLS_DIR" ]] || die "skills/ not found (${SOURCE_SKILLS_DIR})"

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
  log "Update later with the same install command (local or curl one-liner)."
}

if [[ "$MODE" == "uninstall" ]]; then
  uninstall_skills
  exit 0
fi

install_skills
