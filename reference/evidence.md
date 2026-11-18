# Evidence inventory and verification

## When to Load

After reading the report, before drafting anything. Shared by every
hansei skill that turns a report into a narrative.

## Inventory

Before writing, list (for your own use, or show the user on request):

- Headline-scale numbers per domain (updates, builds, reviews,
  packages introduced, PRs merged).
- Named, linkable exemplars: the biggest coordinated stacks (many
  related packages moving together), new packages introduced (review
  requests submitted), major version migrations, upstream PRs with
  real substance, reviews done for other people.
- Anything security-shaped: CVE closures, RUSTSEC responses.
## Never invent; verify what can be verified

Every number and link in the final narrative must come from this
inventory or from the user — never invent or extrapolate. When the
user asserts a current state that the ecosystem's own query tools can
verify (e.g. `fedrq pkgs <name>` for what a distro currently ships, a
Bugzilla `alias`/`blocks` lookup for tracker structure), run the
query and cite the verified fact rather than restating the assertion.

To quantify the scope of an ecosystem-cleanup change (deprecation
removals, mass migrations), query the release *before* the change for
what still depended on the removed thing (e.g. `fedrq whatrequires
<pkg> --src` for build-time and `--notsrc` for runtime scope) — and
when a dependency can be spelled several ways (package name vs
`python3dist()` provide), run both and use the superset.

When the narrative will later be merged with material you cannot see
(e.g. company-internal work), leave explicitly marked placeholders —
*[note for the internal pass: …]* — at the merge points instead of
writing around them.
