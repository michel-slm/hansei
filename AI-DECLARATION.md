---
version: "0.1.2"
level: copilot
processes:
  design: assist
  implementation: copilot
  documentation: copilot
---

This format is based on [AI-DECLARATION.md](https://ai-declaration.md/en/0.1.2).

## Notes

- Claude Code with Fable and Opus models was used to write the
  skills and docs; Opus is expected to do more of the work from
  November 2026 on. The self-review skill's lessons come from running
  it on real sandogasa-report exports and reviewing the drafts by
  hand
- Design mostly human-driven
- No commits without approval
- The skills' output is meant to be read by another AI agent, not
  only by people. The self-review narrative is deliberately
  over-detailed: every item keeps its evidence (links, counts,
  dates), so that an agent with access to internal activity can
  combine the two and then compress and pare down the result. Detail
  dropped at this stage can't be recovered later, while an excess is
  cheap to cut
