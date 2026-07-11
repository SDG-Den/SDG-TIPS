# SDG-TIPS Documentation Plan

## Current Status
One doc file exists (`docs/SDG-TIPS/README.md`, 49 lines). Only one tip file found on disk (`tips/SDG-TIPS/SDG-TIPS-ABOUT/tips.list`, 6 lines), despite the plan claiming 5 exist. The plan needs reconciliation.

## Source-Verified Inventory
**Components:**
- Main CLI: `local/SDG-TIPS/sdg-tips` (240 lines bash)
- Symlinked as: `sdgtip`, `tipme`, `alltips`
- Runtime: globs `~/.local/tips/*/**/*.list` — reads one tip per line
- Commands: random (default), list (fzf), sources, config exclude
- Config: `~/.config/SDG-TIPS/config.toml` (exclusions)
- Deploy: docs → `~/.local/docs/SDG-TIPS/`, tips → `~/.local/tips/SDG-TIPS/`
- Tip format: plain text, one tip per line, optional `[Module Name]: Did you know?` prefix

### Tip File Discrepancy
The plan claims these 5 tip files exist:
| Claimed File | Actually Exists? |
|-------------|-----------------|
| `tips/SDG-TIPS/default-docs.md` | **NO** — not found on disk |
| `tips/SDG-TIPS/default-terminal.md` | **NO** — not found on disk |
| `tips/SDG-TIPS/default-tips.md` | **NO** — not found on disk |
| `tips/SDG-TIPS/fetching.md` | **NO** — not found on disk |
| `tips/SDG-TIPS/SDG-TIPS-ABOUT/tips.list` | **YES** — 6 tips about using sdgtip itself |

The plan also claims these exist as tips:
- `sdgtip` command tips (listed under "existing tips system")
- These are actually in the main `local/SDG-TIPS/tips.list` (168 lines) — the packaged tip file, NOT in `tips/` directory

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-TIPS/`

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | User Guide | CLI commands: sdgtip random, list, sources, config exclude, tipme, alltips | High |
| 2 | Tip Provider Guide | How to ship tips in a module: tips/<MODULE>/tips.list format | High |
| 3 | Agent/AI Integration | Machine-readable output, automation use cases | Medium |
| 4 | Integration with SDG-DOCS | How tips and docs complement each other, sdg-docs integration | Low |

### Existing Content
| File | Notes |
|------|-------|
| `docs/SDG-TIPS/README.md` | 49 lines — covers topics #1 and #2 adequately |

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-TIPS/`

### Existing Tips
| # | Tip | File | Notes |
|---|-----|------|-------|
| 1 | Use sdgtip sources to list modules with tips | `SDG-TIPS-ABOUT/tips.list` | Exists as .list — sdgtip compatible |
| 2 | Use sdgtip list --from MODULE to browse | Same file | |
| 3 | Exclude noisy modules via sdgtip config | Same file | |
| 4 | Each module ships tips under ~/.local/tips/MODULE/ | Same file | |
| 5 | sdgtip CLI aggregates tips automatically | Same file | |
| 6 | Use sdgtip random for a random tip | Same file | |

### Additional Planned Tips (about using sdgtip)
| # | Tip | Priority |
|---|-----|----------|
| 7 | sdgtip random gives you a random tip | High |
| 8 | sdgtip list browses all tips with fzf | Medium |
| 9 | sdgtip --from MODULE filters by module | Medium |
| 10 | sdgtip --format full shows detailed tips | Low |

## Implementation Notes
- The main `local/SDG-TIPS/tips.list` (168 built-in tips) is the primary tip content — it's deployed to `~/.local/SDG-TIPS/tips.list` and is already functional
- The `tips/` directory in source ships meta-tips ABOUT the sdgtip tool itself (tips about tips)
- Reconcile the doc plan: remove claims about 5 nonexistent tip files
- Existing `README.md` is good — only need topics #3 and #4
- Tips about sdgtip usage in `tips/SDG-TIPS/SDG-TIPS-ABOUT/tips.list` are already in correct .list format
