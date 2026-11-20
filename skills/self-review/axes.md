# Self-review: questions and evaluation axes

## When to Load

After the evidence inventory, before clustering: the questions to
ask the user, the direction-axis evidence the report doesn't hold,
and how items map to the evaluation's axes.

## Direction-axis evidence outside the report

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

## Ask the user what the report can't know

Ask 2–4 targeted questions (use the question tool if available),
covering:

1. Which of the big items were **planned deliverables** (mapped to
   team/project goals) vs self-directed? This drives the clustering.
2. **The evaluation's axes** and format, unless a rubric was given
   as an input: ask for the rubric's own wording (pasted, or a path
   to it). Its axis names and descriptions decide the clustering and
   the headings. Also the length limit, form fields, and first vs
   third person.
3. **Invisible work** to include, per axis: committee/SIG leadership
   and policy work (direction), meetings chaired, mentoring and
   onboarding, talks (people), incident response — activity reports
   don't capture these, and their specifics (role names, dates,
   counts) must come from the user, never invented.
4. Anything in the report to **exclude** (other-hat work not relevant
   to this evaluation).

## Cluster along the evaluation's axes

Use the evaluation's own axes, under its own names. The four below
are the default when the user has no rubric at hand. When the rubric
differs, use them as a catalog of kinds of work: map each kind to
the rubric axis that fits it, ask where the fit is unclear, and
don't rename the rubric's axes to these.

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

When the rubric has fewer axes, fold the extra kinds into the
closest one; with the common two buckets (project work and
engineering excellence), Direction and People fold into engineering
excellence. When an item plausibly fits several axes, put it where
the user's goals say it belongs and let the other angle be one
clause, not a second entry.
