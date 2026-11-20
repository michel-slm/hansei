# TODO

## self-review

- (2026-11-20) Known limitation: the evidence sources outside the
  report are Fedora-specific (wiki ChangeSet pages for Changes owned,
  the FE-NEEDSPONSOR tracker for onboarding reviews). Debian is
  planned. Other ecosystems get added when someone who uses them can
  test the skill and give feedback.

- (2026-07-10) The self-review flow proved useful enough on its first
  real run (2026H1, seven passes) that it's worth extending /
  restructuring to also generate **weekly or biweekly narratives**
  from the same sandogasa-report hard facts — e.g. a standing status
  update or snippets feed. Open questions: how much of the current
  skill is period-agnostic (evidence inventory, quirks, never-invent
  rules) vs half-year-specific (the four evaluation axes, Change
  mining, meeting-log deep dives); whether short-period runs should
  diff against the previous period's report rather than narrate from
  scratch.
  - (2026-11-18) The shared core is now in `reference/`
    (`report-format.md`, `evidence.md`); the half-year-specific parts
    (the four axes, Change mining, meeting-log deep dives) are in
    `skills/self-review/axes.md`. A weekly skill would load the
    former and bring its own versions of the latter.
  - (2026-11-19) A concrete case: a status update before a
    planned absence covers a short period and needs a "what's in
    flight and who has it" section, which the notes' open items
    ("Plan: …", "Still to do: …") could feed.
