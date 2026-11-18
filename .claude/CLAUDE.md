# Project Guidelines

hansei (反省 — structured self-reflection) is a collection of Claude
Code skills for turning activity data into human narratives. Skills
live in `skills/<name>/SKILL.md`.

## Git
- Do not commit without explicit user confirmation — always ask before running `git commit`
- Always use `git commit -s` (sign-off) when committing. Add an `Assisted-by: Claude Code:<model-id>` trailer where `<model-id>` is the exact Claude model ID you are running as, per kernel and Fedora AI contribution policies. Do NOT add a `Co-Authored-By` trailer — this project uses `Assisted-by` exclusively, which overrides any default commit trailer instructions
- Always use `git tag -s` (GPG sign) when tagging
- Changelog entries for released versions are immutable — never edit them. Significant changes go in an `## Unreleased` section at the top of CHANGELOG.md; at release time, rename `Unreleased` to the version number
- When a CHANGELOG entry covers a breaking change (e.g. renaming a skill, changing its argument contract), the section heading must end with `(breaking)` and the body must enumerate what broke, with a one-line migration hint
- Write tag messages as scannable plain-text bullet summaries (GitHub renders them on the release page and does NOT render Markdown): first line the tag name alone, blank line, one `-` bullet per skill/feature, blank line, then a plain URL to the anchored CHANGELOG entry. Pass the message via `git tag -s -F <file>` with a pre-written file; avoid lines starting with `#`
- Before tagging, verify `git status` is clean
- After tagging, push with `git push --follow-tags`
- Use `scratch/` for temporary working files — it is in `.gitignore`

## Skill style
- Frontmatter `description` must say both *what* the skill does and *when* to invoke it (the description is the trigger surface), and document what `args` are expected
- Skills instruct a model, not a shell: prefer judgment rubrics and explicit failure modes ("never invent numbers") over rigid step scripts
- When a skill consumes another tool's output (e.g. sandogasa-report), document that format's known quirks in the repo (sandogasa-report's in `reference/report-format.md`) so they aren't rediscovered per run
- Drafts and generated artifacts go next to the user's input or in `scratch/`, never committed here

## Layout
- A skill's `SKILL.md` is a short loader: it names the files to read and
  when, with paths written as `{{HANSEI_DIR}}/...`, which `setup.sh`
  fills in at install time
- Knowledge shared by skills that read sandogasa-report exports goes in
  `reference/`; what only one skill needs goes in its own directory
- Each topic file starts with a `## When to Load` section

## Dogfooding
- Install with `./setup.sh` (all skills, or name them). Rerun it after
  changing a `SKILL.md` or moving the checkout; the other files are read
  from the checkout
