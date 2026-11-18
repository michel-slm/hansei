# Changelog

## Unreleased

### self-review: current sandogasa-report output

Item lists need `--detailed --detailed` since sandogasa-report
0.24.0; the README's export command used one `--detailed` and an
`--until` one day past the half-year (it is inclusive). The skill now
knows the per-instance Bugzilla sections, the `By repository` table,
the `(merged)`/`(applied)`/`(closed)` PR markers, that zero rows are
gone, and that GitHub review counts are a lower bound.

### New self-review skill

Turn a sandogasa-report markdown export into a first-person
self-review narrative, clustered into project work and engineering
excellence / better engineering. Reads the full report (with its
known quirks: pushed-vs-authored commits, per-release Bodhi fan-out,
bugs closed via updates), builds an evidence inventory, asks what the
report cannot know, and drafts with every number traceable to the
report.
