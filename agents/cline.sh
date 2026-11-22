#!/bin/bash
#
# From review-prompts (https://github.com/masoncl/review-prompts),
# MIT License, Copyright (c) 2025 Chris Mason; see agents/LICENSE.
# Only the install paths are kept: review-prompts' version also
# overrides its setup.sh's install_project(), which hansei doesn't have.
#
# Agent setup script for Cline (https://cline.bot).
#
# Sourced by setup.sh. Cline reads each skill from a directory under
# ~/.cline/skills/<name>/ containing a SKILL.md with YAML frontmatter
# (name + description), which hansei's skills already have.
# Reference: https://docs.cline.bot/customization/skills
#
# Author: Breno Leitao <leitao@debian.org>

export SKILL_BASE_DIR="$HOME/.cline/skills"
export COMMANDS_DIR="$HOME/.cline/skills"
export SKILL_FILE_NAME="SKILL.md"
