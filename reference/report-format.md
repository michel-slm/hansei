# sandogasa-report exports: structure and quirks

## When to Load

Always, before reading a sandogasa-report export. Shared by every
hansei skill that consumes one.

## Structure

sandogasa-report emits `## <domain>` (e.g. upstream, hyperscale,
fedora, debian — the user's own grouping) → `### <service>` (GitHub,
GitLab, Koji, Bodhi, Sourcehut, Forgejo) → `#### <detail>`
subsections. Bugzilla is not nested under each domain: since 0.24.0
each Bugzilla instance (Red Hat's, openSUSE's) gets one section of
its own, placed after the last domain that uses it. A report run with
`--by repo` (0.27.0) ends with a `## By repository` table that
regroups the same data per repository across all forges. Detailed
exports run thousands of lines; read it all in chunks before writing
anything.

## Quirks

Known quirks — get these right or the numbers will be wrong:

- **"Commits pushed" vs "commits authored"** are different: pushed
  counts include other people's commits the user pushed (e.g. syncing
  dist-git mirrors). Authored is the personal-contribution number;
  pushed can still show scale of integration work. Never add them.
  GitHub reports only authored commits; the `By repository` table's
  Commits column is pushed.
- **Zero rows**: exports before 0.22.0 print lines such as "Releases
  published: 0 across 0 project(s)"; ignore them. Newer exports drop
  them, so a missing line means no activity, or a source skipped with
  a `--no-*` flag; check the command line before saying "none".
- **PR/MR fate markers** on the opened lists (GitHub, GitLab and
  Forgejo, 0.24.0): `(merged)`; `(applied)`, a PR closed unmerged
  whose commits still landed (cherry-picked, fast-forwarded or
  rebased by the maintainer), which counts as landed work; and
  `(closed)`, which includes changes the maintainer redid
  themselves. Count merged + applied as landed; don't present
  closed ones as failures without checking.
- **GitHub reviews and comments are a lower bound.** They come from
  GitHub's user events API, which returns at most the 300 most recent
  events (and, per GitHub's docs, only the last 90 days). A half-year
  report generated after the period ends misses older reviews. Say
  "at least N", and suggest generating reports quarterly or soon
  after each period.
- **Sourcehut** commits count only the addresses listed in the
  user's `git_emails`, and ticket counts appear only when the report
  is about the token owner.
- In the **Bugzilla table**, "Closed" counts bugs closed *by the
  user's updates* (e.g. hundreds of Security/CVE closures from
  routine version bumps) — real impact, but say "closed via updates",
  not "personally triaged".
- **Bodhi** lists updates per release; the same source-package bump
  appears once per release. Count distinct efforts, not rows, when
  narrating ("updated X across N releases").
- Tags/updates with the same stem across many releases are one piece
  of work fanned out; aggregate them.
