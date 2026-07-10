# hansei

hansei (反省, "self-reflection") is a collection of [Claude
Code](https://claude.com/claude-code) skills for turning mechanical
activity data into narratives written for humans.

## Skills

### self-review

Turns a [sandogasa-report](https://github.com/slopfest/sandogasa)
markdown export into a first-person self-review narrative for a
performance evaluation, clustered into **project work** (planned
deliverables and their outcomes) and **engineering excellence /
better engineering** (reviews for others, security response, health
cleanups, tooling that removes toil). The skill reads the whole
report, builds an evidence inventory, asks the few questions the
report can't answer (which items were planned goals, invisible work
like meetings chaired or mentoring), and drafts a narrative where
every number traces back to the report.

```
/self-review scratch/report-michel-2026h1-detailed2.md 2026H1
```

#### Generating the raw material

The skill works from a
[sandogasa-report](https://github.com/slopfest/sandogasa) export, so
set that up first:

1. Run `sandogasa-report config -c <config.toml>` once — it walks
   every forge instance used by the config's domains and prompts for
   the full credential set (usernames and API tokens for
   GitLab/GitHub/Forgejo/Sourcehut, FAS username, Bugzilla email),
   which covers any domain combination you later report on. See the
   sandogasa-report README's Configuration section for the
   main-config / per-user-overlay split.
2. Export the period with `--detailed` (the skill wants individual
   items, not just counts):

   ```sh
   sandogasa-report report -c config.toml --user <you> \
       -d <domain> [-d <domain> ...] \
       --since 2026-01-01 --until 2026-07-01 \
       --detailed -o report-2026h1.md
   ```

## Installation

Symlink the skill(s) you want into your user skills directory:

```sh
ln -s "$(pwd)/skills/self-review" ~/.claude/skills/self-review
```

or, for a single project, into that project's `.claude/skills/`.

## License

Licensed under either of

- [Apache License, Version 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)

at your option.
