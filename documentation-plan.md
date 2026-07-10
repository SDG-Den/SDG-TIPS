# SDG-TIPS Documentation Plan

## Current Status
One doc file exists (`docs/README.md`, full documentation). 5 tip files exist in `tips/`. The package contains its own doc system (sdgtip CLI) and tips are both consumed by and provided to the broader SDG-TIPS system.

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-TIPS/`

### Existing Docs
| File | Topic |
|------|-------|
| README.md | Full documentation: CLI options, file location conventions, XDG base dir spec, extension docs, machine-readable output |

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | User Guide | How sdgtip works, showing random tips, filtering by module | High |
| 2 | Tip Provider Guide | How to create tip files, tips.list format, multi-line tips, extensions | High |
| 3 | Agent/AI Integration | Machine-readable output, pipe-friendly `-f` flag | Medium |
| 4 | Integration with SDG-DOCS | How tips and docs complement each other in the help ecosystem | Low |

### Implementation
- Convert existing README.md into focused topic files
- Follow SDG-DOCS naming convention

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-TIPS/`

### Existing Tips (5)
| File | Topic |
|------|-------|
| tips.list | Main tip aggregation (titles + one-liners) |
| default-docs.md | How docs are the default for sdg-docs |
| default-terminal.md | How to open a terminal |
| default-tips.md | How tips provide shorthand guidance |
| fetching.md | How to use sdg-fetch for system info |

### Planned Tips
| # | Tip | Description | Priority |
|---|-----|-------------|----------|
| 1 | Random tip | Run `sdgtip` for a random tip | High |
| 2 | Module tips | `sdgtip --from <module>` to filter by module | High |
| 3 | Tip format | `sdgtip --format full` for detailed tips with explanation | Medium |
| 4 | List modules | `sdgtip --sources` to see available tip modules | Medium |
| 5 | File-based tips | Tips live at `~/.local/tips/<MODULE>/tips.list` | Low |

### Implementation
- Keep existing tips, add sdgtip CLI usage tips
- Ensure `tips.list` is in proper format
