#!/bin/bash
#
# Install hansei's skills for Claude Code.
#
# Usage: ./setup.sh [skill ...]
#
# Each skill lives in skills/<name>/. Its SKILL.md is copied to
# ~/.claude/skills/<name>/SKILL.md with {{HANSEI_DIR}} replaced by this
# checkout's path; the other files it loads (reference/, the skill's own
# topic files) are read from the checkout, so editing them needs no
# reinstall. Rerun after changing a SKILL.md or moving the checkout.
# With no arguments, every skill is installed.

set -e

HANSEI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# The path as sed replacement text: escape \ first, then & and the | delimiter.
sed_dir="${HANSEI_DIR//\\/\\\\}"
sed_dir="${sed_dir//&/\\&}"
sed_dir="${sed_dir//|/\\|}"
SKILLS_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"

usage() {
    echo "Usage: $0 [skill ...]"
    echo "Install hansei skills into $SKILLS_DIR."
    echo "Available skills:"
    for d in "$HANSEI_DIR"/skills/*/; do
        echo "  $(basename "$d")"
    done
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    usage
    exit 0
fi

if [ $# -eq 0 ]; then
    all=()
    for d in "$HANSEI_DIR"/skills/*/; do
        all+=("$(basename "$d")")
    done
    set -- "${all[@]}"
fi

for skill in "$@"; do
    src="$HANSEI_DIR/skills/$skill/SKILL.md"
    if [ ! -f "$src" ]; then
        echo "Error: no such skill: $skill" >&2
        usage >&2
        exit 1
    fi
    dest="$SKILLS_DIR/$skill"
    if [ -L "$dest" ]; then
        # An older install symlinked the whole skill directory.
        echo "Replacing symlink $dest"
        rm "$dest"
    fi
    mkdir -p "$dest"
    sed "s|{{HANSEI_DIR}}|$sed_dir|g" "$src" > "$dest/SKILL.md"
    echo "Installed $skill to $dest/SKILL.md"
done
