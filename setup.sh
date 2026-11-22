#!/bin/bash
#
# Install hansei's skills for a coding agent.
#
# Usage: ./setup.sh [-a <agent>] [skill ...]
#
# Each skill lives in skills/<name>/. Its SKILL.md is copied to the
# agent's skill directory (for Claude Code, the default,
# ~/.claude/skills/<name>/SKILL.md) with {{HANSEI_DIR}} replaced by
# this checkout's path; the other files it loads (reference/, the
# skill's own topic files) are read from the checkout, so editing them
# needs no reinstall. Rerun after changing a SKILL.md or moving the
# checkout. With no skills named, every skill is installed.
#
# agents/<agent>.sh sets where each agent looks for skills; they come
# from review-prompts, which installs the same way.

set -e

HANSEI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# The path as sed replacement text: escape \ first, then & and the | delimiter.
sed_dir="${HANSEI_DIR//\\/\\\\}"
sed_dir="${sed_dir//&/\\&}"
sed_dir="${sed_dir//|/\\|}"
agent=claude

usage() {
    echo "Usage: $0 [-a <agent>] [skill ...]"
    echo "Install hansei skills for a coding agent (default: claude)."
    echo "Agents:"
    for f in "$HANSEI_DIR"/agents/*.sh; do
        f=$(basename "$f")
        echo "  ${f%.sh}"
    done
    echo "Skills:"
    for d in "$HANSEI_DIR"/skills/*/; do
        echo "  $(basename "$d")"
    done
}

while [ $# -gt 0 ]; do
    case $1 in
        -h|--help) usage; exit 0 ;;
        -a) [ $# -ge 2 ] || { usage >&2; exit 1; }; agent=$2; shift 2 ;;
        -a*) agent=${1#-a}; shift ;;
        --) shift; break ;;
        -*) echo "Error: unknown option: $1" >&2; usage >&2; exit 1 ;;
        *) break ;;
    esac
done

agent_script="$HANSEI_DIR/agents/$agent.sh"
if [ ! -f "$agent_script" ]; then
    echo "Error: no such agent: $agent" >&2
    usage >&2
    exit 1
fi
# shellcheck source=/dev/null
. "$agent_script"
SKILLS_DIR=$SKILL_BASE_DIR
if [ "$agent" = claude ] && [ -n "${CLAUDE_CONFIG_DIR:-}" ]; then
    SKILLS_DIR=$CLAUDE_CONFIG_DIR/skills
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
    sed "s|{{HANSEI_DIR}}|$sed_dir|g" "$src" > "$dest/$SKILL_FILE_NAME"
    echo "Installed $skill to $dest/$SKILL_FILE_NAME"
done
