---
name: self-review
description: Turn a sandogasa-report activity export (markdown) into a first-person self-review narrative for a performance evaluation, clustered along the evaluation's own axes (by default project work, engineering excellence / better engineering, direction, and people). Use when the user asks to draft, structure, or polish a self-review or perf narrative from an activity report. Pass the report path (and optionally a period label like 2026H1 and the path to the evaluation's rubric) as args.
---

# Self-review narrative from a sandogasa-report export

You are turning a mechanical activity report into a narrative a human
submits for their own performance evaluation. The report is evidence,
not the story: your job is to select, cluster, and narrate — never to
dump.

## Inputs

- **Report path**: from args; otherwise use the newest
  `scratch/report-*.md` and confirm the choice with the user.
  The skill needs the individual items, which since sandogasa-report
  0.24.0 means a `--detailed --detailed` export; a single
  `--detailed` now gives only counts per repo or component. (Older
  exports listed the items with one `--detailed`.) If the report has
  counts but no items, ask for a new export rather than narrating
  from counts.
- **Period label** (e.g. `2026H1`): from args or the report's
  `**Period:**` line.
- **Rubric** (optional): a path to the evaluation's axes or form,
  from args; without one, step 3 asks for it.

## Load in this order

Paths are filled in by `setup.sh` at install time.

1. `{{HANSEI_DIR}}/reference/report-format.md` — always, before
   reading the report: its structure and the quirks that make
   numbers wrong. Read the whole report, in chunks, before step 2.
2. `{{HANSEI_DIR}}/reference/evidence.md` — build the evidence
   inventory and verify what tools can verify.
3. `{{HANSEI_DIR}}/skills/self-review/axes.md` — direction-axis
   evidence outside the report, the questions to ask the user, and
   clustering along the evaluation's axes.
4. `{{HANSEI_DIR}}/skills/self-review/writing.md` — drafting the
   narrative, and the pass files for each revision round.

Don't draft before steps 1–3 are done: the questions in step 3
decide the clustering.
