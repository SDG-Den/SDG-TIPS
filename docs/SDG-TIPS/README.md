# Tips System

Modular tip display system that aggregates tips from all installed SDG-OS
modules and displays them on demand.

## Architecture

Each module can ship tip files under `tips/MODULE/tips.list` in its source
repo.  During installation these are deployed to `~/.local/tips/MODULE/`.
The `sdgtip` CLI globs `~/.local/tips/*/` at runtime and collects every
`.list` file it finds, so tips from every installed module are available
automatically.

### Virtual tip sub-modules

Tip files can also be organised into subdirectories under a module's
`tips/` directory.  These are called *virtual tip modules* and are listed
as sub-sources by `sdgtip sources`.  A virtual tip module can be split
into its own repository later without changing any consumer paths.

## Commands

| Command | Action |
|---------|--------|
| `sdgtip` | Show a random tip from all sources |
| `sdgtip random --from MODULE` | Random tip from one module |
| `sdgtip list` | Browse all tips interactively (fzf) |
| `sdgtip list --from MODULE` | Browse tips from one module |
| `sdgtip sources` | List available tip sources with counts |
| `sdgtip config exclude add MODULE` | Exclude a module from tip selection |
| `sdgtip config exclude remove MODULE` | Re-include a module |
| `sdgtip config exclude list` | Show excluded modules |

## Legacy aliases

| Old | Maps to |
|-----|---------|
| `tipme` | `sdgtip random` |
| `alltips` | `sdgtip list` |
| `SUPER+0` | `sdgtip random` (via desktop notification) |

## Files

| File | Purpose |
|------|---------|
| `local/SDG-TIPS/sdg-tips` | CLI entrypoint (symlinked to `/usr/bin/sdgtip`) |
| `local/SDG-TIPS/tips.list` | Primary general tip collection |
| `tips/SDG-TIPS/*/tips.list` | Categorised sub-module tip files |
| `config/SDG-TIPS/config.toml` | User exclusion list |
