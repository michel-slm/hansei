---
name: self-review
description: Turn a sandogasa-report activity export (markdown) into a first-person self-review narrative for a performance evaluation, clustered along the evaluation's axes — project work, engineering excellence / better engineering, direction (committee and distribution leadership), and people (mentoring, onboarding, talks). Use when the user asks to draft, structure, or polish a self-review or perf narrative from an activity report. Pass the report path (and optionally a period label like 2026H1) as args.
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
- **Meeting minutes and logs** (e.g. meetbot archives) for the
  direction axis. Attendance and chairing counts set the baseline —
  but chairing is *procedural* (agendas, minutes), not a claim to
  the decisions made. The substance is the user's own record in the
  full `.log.txt` transcripts: extract their votes per topic and
  their statements on marquee items. Prioritize **rejected
  proposals** and **non-unanimous votes** — how the user voted
  relative to the outcome (defended a change against reversion,
  abstained while shaping a constructive rejection, iterated a
  proposal to approvable) is where judgment shows. A short script
  against the archive beats asking the user to remember.
- Formal change proposals behind the big efforts (e.g. Fedora Change
  pages on the wiki): they name co-owners, the accepted status, the
  target release, and the *rationale* — which upgrades a pile of
  updates into "executed an accepted distribution Change", and counts
  toward direction when the user authored it. Don't rely on the user
  volunteering them: fetch the target release's **ChangeSet page**
  (e.g. `Releases/44/ChangeSet`) and list every Change the user owns.
  Caveat: the wiki proposal is the *plan*; what landed may differ
  (different versions, different packaging shape) — the activity
  report is the ground truth for delivery, so describe execution from
  report evidence and flag divergences instead of restating the
  proposal as fact.

Every number and link in the final narrative must come from this
inventory or from the user — never invent or extrapolate. When the
user asserts a current state that the ecosystem's own query tools can
verify (e.g. `fedrq pkgs <name>` for what a distro currently ships, a
Bugzilla `alias`/`blocks` lookup for tracker structure), run the
query and cite the verified fact rather than restating the assertion.

When the narrative will later be merged with material you cannot see
(e.g. company-internal work), leave explicitly marked placeholders —
*[note for the internal pass: …]* — at the merge points instead of
writing around them.

## 3. Ask the user what the report can't know

Ask 2–4 targeted questions (use the question tool if available),
covering:

1. Which of the big items were **planned deliverables** (mapped to
   team/project goals) vs self-directed? This drives the clustering.
2. **Which axes** the evaluation actually uses (two-bucket project
   work + better engineering, or four with direction and people) and
   its format: length limit, form fields, first vs third person.
3. **Invisible work** to include, per axis: committee/SIG leadership
   and policy work (direction), meetings chaired, mentoring and
   onboarding, talks (people), incident response — activity reports
   don't capture these, and their specifics (role names, dates,
   counts) must come from the user, never invented.
4. Anything in the report to **exclude** (other-hat work not relevant
   to this evaluation).

## 4. Cluster along the evaluation's axes

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

- Reviews done for others (package reviews, PR/MR reviews).
- Security response: CVE triage, advisory-driven bumps, closures.
- Health cleanups: FTBFS/FTI fixes, nonresponsive-maintainer and
  policy processes, dead-weight removal.
- Tooling and automation built that removes toil (name what it
  automates and who benefits, not just what it is).
- Upstream fixes that unblock downstream, documentation, process
  improvements.

**Direction** — setting or steering where a project/community goes
(mostly invisible in activity reports; source it from the user):

- Elected/appointed committee service (e.g. a distribution steering
  committee): membership, chairing, policy decisions driven.
- SIG / working-group leadership: roadmap, priorities, process.
- Proposals and policy changes authored or shepherded.

**People** — growing other contributors:

- Mentoring and onboarding (new packagers, co-maintainers invited
  and coached — co-maintainer offers in review/branch requests are
  report-visible evidence).
- Talks, demos, and written knowledge-sharing (a talk may only be
  visible as slide commits — ask).
- Reviews count as mentoring/onboarding **only when the requester is
  demonstrably new** — verify before claiming. For Fedora the
  mechanical check: a review request that **blocks the
  FE-NEEDSPONSOR tracker (bug 177841)** comes from a packager with
  no sponsor yet — reviewing (and sponsoring) those is
  definitionally onboarding; query the review bugs' `blocks` field
  via the Bugzilla REST API. Fallback heuristic: the requester's FAS
  group memberships / existing package access (a seasoned SIG
  member's stack review is not onboarding). Unverified, the honest
  framing is that reviews *unblock others* and build reciprocity —
  maintainers who get their packages reviewed are more willing to
  review yours — which belongs under engineering excellence, not
  people.

Default mapping when the evaluation only has two buckets: fold
Direction and People into engineering excellence. When an item
plausibly fits several axes, put it where the user's goals say it
belongs and let the other angle be one clause, not a second entry.

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

Write the draft next to the report as
`scratch/self-review-<period>-pass1.md`, show the user the cluster
headlines first, and iterate. **Every revision round writes a new
file** (`-pass2`, `-pass3`, …) — never overwrite an earlier pass, so
the user can diff passes and recover dropped phrasing. Expect wording
rounds: this text goes in front of the user's management, so the user
has final say on every claim.
