---
name: self-review
description: Turn a sandogasa-report activity export (markdown) into a first-person self-review narrative for a performance evaluation, clustered into "project work" and "engineering excellence / better engineering". Use when the user asks to draft, structure, or polish a self-review or perf narrative from an activity report. Pass the report path (and optionally a period label like 2026H1) as args.
---

# Self-review narrative from a sandogasa-report export

You are turning a mechanical activity report into a narrative a human
submits for their own performance evaluation. The report is evidence,
not the story: your job is to select, cluster, and narrate — never to
dump.

## Inputs

- **Report path**: from args; otherwise use the newest
  `scratch/report-*.md` and confirm the choice with the user.
  Prefer a `--detailed` export when one exists (it lists individual
  items, not just counts).
- **Period label** (e.g. `2026H1`): from args or the report's
  `**Period:**` line.

## 1. Read the report — structure and quirks

sandogasa-report emits `## <domain>` (e.g. upstream, hyperscale,
fedora, debian — the user's own grouping) → `### <service>` (GitHub,
GitLab, Koji, Bodhi, Bugzilla, Sourcehut, Forgejo) → `#### <detail>`
subsections. Detailed exports run thousands of lines; read it all in
chunks before writing anything.

Known quirks — get these right or the numbers will be wrong:

- **"Commits pushed" vs "commits authored"** are different: pushed
  counts include other people's commits the user pushed (e.g. syncing
  dist-git mirrors). Authored is the personal-contribution number;
  pushed can still show scale of integration work. Never add them.
- **Zero rows** ("Releases published: 0 across 0 project(s)") are
  noise; ignore them.
- In the **Bugzilla table**, "Closed" counts bugs closed *by the
  user's updates* (e.g. hundreds of Security/CVE closures from
  routine version bumps) — real impact, but say "closed via updates",
  not "personally triaged".
- **Bodhi** lists updates per release; the same source-package bump
  appears once per release. Count distinct efforts, not rows, when
  narrating ("updated X across N releases").
- Tags/updates with the same stem across many releases are one piece
  of work fanned out; aggregate them.

## 2. Build an evidence inventory

Before writing, list (for your own use, or show the user on request):

- Headline-scale numbers per domain (updates, builds, reviews,
  packages introduced, PRs merged).
- Named, linkable exemplars: the biggest coordinated stacks (many
  related packages moving together), new packages introduced (review
  requests submitted), major version migrations, upstream PRs with
  real substance, reviews done for other people.
- Anything security-shaped: CVE closures, RUSTSEC responses.

Every number and link in the final narrative must come from this
inventory or from the user — never invent or extrapolate.

## 3. Ask the user what the report can't know

Ask 2–4 targeted questions (use the question tool if available),
covering:

1. Which of the big items were **planned deliverables** (mapped to
   team/project goals) vs self-directed? This drives the clustering.
2. **Invisible work** to include: meetings chaired, mentoring,
   design/process documents, incident response, community governance
   (e.g. committee work) — activity reports don't capture these.
3. **Audience constraints**: length limit, form fields, whether
   "engineering excellence"/"better engineering" is the reviewer's
   actual rubric wording, first person vs third person.
4. Anything in the report to **exclude** (other-hat work not relevant
   to this evaluation).

## 4. Cluster: project work vs engineering excellence

**Project work** — planned deliverables and their outcomes:

- Coordinated multi-package upgrades landed (staged in COPR/side
  tags, shipped via Bodhi), with the size of the stack and releases
  covered.
- New packages introduced (from review request to shipping).
- Branch/platform enablement (e.g. bringing a stack to EPEL).
- Major version migrations completed.
- Feature work in owned projects (tools shipped, releases cut).

**Engineering excellence / better engineering** — work that makes
other people's and future work better:

- Reviews done for others (package reviews, PR/MR reviews) and
  co-maintainer onboarding.
- Security response: CVE triage, advisory-driven bumps, closures.
- Health cleanups: FTBFS/FTI fixes, nonresponsive-maintainer and
  policy processes, dead-weight removal.
- Tooling and automation built that removes toil (name what it
  automates and who benefits, not just what it is).
- Upstream fixes that unblock downstream, documentation, process
  improvements.

When an item plausibly fits both, put it where the user's goals say
it belongs and let the other angle be one clause, not a second entry.

## 5. Write the narrative

- First person, past tense, impact first: each cluster opens with
  its 2–3 headline achievements — one short paragraph each: what,
  scale (numbers from the inventory), why it mattered, one or two
  evidence links.
- Then a compact "also" tier: aggregate the long tail into single
  sentences with counts ("…plus ~N routine updates across M
  releases").
- Calibrated verbs: "led/landed/coordinated" only where the evidence
  supports it; "contributed to" where it doesn't.
- No laundry lists, no tool-name soup, no modesty hedges, no
  superlatives the numbers don't back.
- Keep a short **appendix table** of the raw headline stats (per
  domain) so the narrative can stay lean while the evidence stays
  attached.

## 6. Output and iteration

Write the draft next to the report (e.g.
`scratch/self-review-<period>.md`), show the user the two cluster
headlines first, and iterate. Expect wording rounds: this text goes
in front of the user's management, so the user has final say on every
claim.
