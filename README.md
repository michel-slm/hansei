# hansei

[![AI-DECLARATION: copilot](https://img.shields.io/badge/䷼%20AI--DECLARATION-copilot-fee2e2?labelColor=fee2e2)](https://ai-declaration.md)

hansei (反省, "self-reflection") is a collection of coding-agent
skills for turning mechanical activity data into narratives written
for humans. They are written and tested with
[Claude Code](https://claude.com/claude-code), and use the `SKILL.md`
format that Codex, Gemini CLI and other agents also read.

## Skills

### self-review

Turns a [sandogasa-report](https://github.com/michel-slm/sandogasa)
markdown export into a first-person self-review narrative for a
performance evaluation, clustered along the evaluation's own axes.
Give it the rubric, or it asks; without one it uses **project work**
(planned deliverables and their outcomes), **engineering excellence
/ better engineering** (reviews for others, security response,
health cleanups, tooling that removes toil), **direction** and
**people**. The skill reads the whole report, builds an evidence
inventory, asks the few questions the report can't answer (which
items were planned goals, invisible work like meetings chaired or
mentoring), and drafts a narrative where every number traces back
to the report.

```
/self-review scratch/report-2026h1.md 2026H1 [rubric.md]
```

#### Generating the raw material

The skill works from a
[sandogasa-report](https://github.com/michel-slm/sandogasa) export, so
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
       --detailed --detailed --by repo --notes --private \
       -o report-2026h1.md
   ```

   `--notes` adds your work notes, the reasons behind items, which
   the skill uses for clustering and for why the work mattered.
   `--private` keeps what a shared report leaves out: GitHub work in
   private repositories, and notes on items the report doesn't show,
   notes without a URL, and notes under embargo. Such an export is
   for your own use: don't share it as is. (Both options are
   unreleased in sandogasa-report as of 2026-11-19.)

   From the release after sandogasa-report 0.28 (sandogasa cf55a9f1),
   GitHub commit counts, reviews and PR comments cover the whole
   period; earlier versions read them from GitHub's last 300 events
   and miss older work. Releases, pushes to forks and tags in busy
   repositories still come from recent data, so export within a few
   weeks of the period's end. sandogasa-report's README lists the
   remaining gaps.

   Before drafting, look for significant items that have no note but
   need a reason, and add notes for them
   (`sandogasa-report note`); the 2026-11 run backfilled 53.

## Installation

Install the skills with the setup script:

```sh
./setup.sh claude              # every skill, for Claude Code
./setup.sh claude self-review  # or only some
./setup.sh codex               # for OpenAI's Codex CLI
```

It copies each skill's `SKILL.md` into the agent's skill directory
(`~/.claude/skills/<name>/` for Claude Code), filling in this
checkout's path; the files a skill loads are read from the checkout,
so only a changed `SKILL.md` (or a moved checkout) needs a rerun. It
replaces a symlink left by the earlier install instructions.

Agents (`./setup.sh -h` lists them): `claude`, `cline`,
`codex` (OpenAI's Codex CLI), `gemini`, `goose`, `kiro-cli` and
`opencode`. Their install paths in `agents/` come from
[review-prompts](https://github.com/masoncl/review-prompts) (MIT
License, see `agents/LICENSE`). Only Claude Code has been tested so
far; reports from users of the others are welcome. goose also reads
`~/.claude/skills`, so install for one of the two, not both, or the
skill shows up twice.

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
