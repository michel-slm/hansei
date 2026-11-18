# hansei

[![AI-DECLARATION: copilot](https://img.shields.io/badge/䷼%20AI--DECLARATION-copilot-fee2e2?labelColor=fee2e2)](https://ai-declaration.md)

hansei (反省, "self-reflection") is a collection of [Claude
Code](https://claude.com/claude-code) skills for turning mechanical
activity data into narratives written for humans.

## Skills

### self-review

Turns a [sandogasa-report](https://github.com/slopfest/sandogasa)
markdown export into a first-person self-review narrative for a
performance evaluation, clustered into **project work** (planned
deliverables and their outcomes) and **engineering excellence /
better engineering** (reviews for others, security response, health
cleanups, tooling that removes toil). The skill reads the whole
report, builds an evidence inventory, asks the few questions the
report can't answer (which items were planned goals, invisible work
like meetings chaired or mentoring), and drafts a narrative where
every number traces back to the report.

```
/self-review scratch/report-2026h1.md 2026H1
```

#### Generating the raw material

The skill works from a
[sandogasa-report](https://github.com/slopfest/sandogasa) export, so
set that up first:

1. Run `sandogasa-report config -c <config.toml>` once — it walks
   every forge instance used by the config's domains and prompts for
   the full credential set (usernames and API tokens for
   GitLab/GitHub/Forgejo/Sourcehut, FAS username, Bugzilla email),
   which covers any domain combination you later report on. See the
   sandogasa-report README's Configuration section for the
   main-config / per-user-overlay split.
2. Export the period with `--detailed --detailed`: the skill wants
   the individual items, and since sandogasa-report 0.24.0 a single
   `--detailed` gives only counts per repo. `--by repo` adds a
   per-repository table, which helps with project-level exemplars:

   ```sh
   sandogasa-report report -c config.toml --user <you> \
       -d <domain> [-d <domain> ...] \
       --since 2026-01-01 --until 2026-06-30 \
       --detailed --detailed --by repo -o report-2026h1.md
   ```

   GitHub review and comment counts come from an API that keeps only
   recent events, so export soon after the period ends (or each
   quarter) to keep them complete.

## Installation

Install the skills with the setup script:

```sh
./setup.sh              # every skill
./setup.sh self-review  # or only some
```

It copies each skill's `SKILL.md` to `~/.claude/skills/<name>/`,
filling in this checkout's path; the files a skill loads are read
from the checkout, so only a changed `SKILL.md` (or a moved checkout)
needs a rerun. It replaces a symlink left by the earlier install
instructions.

## Layout

Each skill's `SKILL.md` is a short loader that names the files to
read and when, the way
[review-prompts](https://github.com/slopfest/review-prompts) does:

| File | Purpose | Loaded |
|------|---------|--------|
| `reference/report-format.md` | sandogasa-report structure and quirks | Always, before reading a report |
| `reference/evidence.md` | Evidence inventory, never-invent and verification rules | Before drafting |
| `skills/self-review/axes.md` | Questions to ask; evaluation axes and clustering | self-review, before clustering |
| `skills/self-review/writing.md` | Narrative rules; pass files per revision | self-review, when drafting |

`reference/` is shared by every skill that reads a sandogasa-report
export; a skill's own directory holds what is specific to it.

## License

Licensed under either of

- [Apache License, Version 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)

at your option.
