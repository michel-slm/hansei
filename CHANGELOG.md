# Changelog

## Unreleased

### self-review: classify reviews before drafting

The FE-NEEDSPONSOR check (does a review block bug 177841?) is now a
step of the evidence inventory, run in batched Bugzilla queries
before clustering, instead of a note in the People axis, where it
was easy to skip until late in the revisions. The inventory also
counts later reviews for the same new packager with the first, and
sends ids in groups of 20, the most Red Hat Bugzilla returns per
request.

### Install for other coding agents

`./setup.sh <agent>` installs the skills for Claude Code (`claude`),
Cline, Codex, Gemini CLI, goose, Kiro CLI or opencode, as
review-prompts' setup does; the agents' skill directories come from
it. Only Claude Code has been tested.

### Skills split into a loader and topic files

`SKILL.md` now only names the files to load and when;
sandogasa-report knowledge shared between skills moved to
`reference/`. Install with `./setup.sh <agent>` (e.g.
`./setup.sh claude`) instead of symlinking the skill directory: the
loader needs this checkout's path filled in. Rerun it after pulling
a change to a `SKILL.md`.

### self-review: current sandogasa-report output

Item lists need `--detailed --detailed` since sandogasa-report
0.24.0; the README's export command used one `--detailed` and an
`--until` one day past the half-year (it is inclusive). The skill now
knows the per-instance Bugzilla sections, the `By repository` table,
the `(merged)`/`(applied)`/`(closed)` PR markers, that zero rows are
gone, and which GitHub numbers are a lower bound (all reviews and
comments up to sandogasa-report 0.28; releases, fork pushes and tags
after). The README's export command adds `--notes` and `--private`.

### self-review: the evaluation's own axes

The skill asks for the evaluation's rubric, or takes its path as an
argument, and clusters under the rubric's axes. Project work,
engineering excellence, direction and people are the default without
one, and otherwise a catalog of kinds of work to map onto the
rubric. Rerun `./setup.sh <agent>`: `SKILL.md` changed.

## 26.07

### New self-review skill

Turn a sandogasa-report markdown export into a first-person
self-review narrative, clustered into project work and engineering
excellence / better engineering. Reads the full report (with its
known quirks: pushed-vs-authored commits, per-release Bodhi fan-out,
bugs closed via updates), builds an evidence inventory, asks what the
report cannot know, and drafts with every number traceable to the
report.
