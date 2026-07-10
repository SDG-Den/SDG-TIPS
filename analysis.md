# SDG-TIPS Analysis

## Type
Tip-of-the-Day System (Knowledge Module)

## Description
SDG-TIPS is the modular tip-of-the-day system for SDG-OS. It aggregates tip files from every installed module's `~/.local/tips/<MODULE>/` directory and provides a CLI engine for displaying them.

## CLI Entry Points
| Command | Symlink | Description |
|---------|---------|-------------|
| `sdgtip` | `/usr/bin/sdgtip` | Direct access (random by default) |
| `tipme` | `/usr/bin/tipme` | Random tip |
| `alltips` | `/usr/bin/alltips` | List all tips (fzf browser) |

### Commands
| Subcommand | Description |
|------------|-------------|
| `sdgtip random` | Show random tip |
| `sdgtip list` | Browse all tips with fzf |
| `sdgtip sources` | List all modules with tip counts |
| `sdgtip config exclude add <module>` | Exclude a module |
| `sdgtip config exclude remove <module>` | Re-include a module |
| `sdgtip config exclude list` | Show exclusions |
| `--from MODULE` | Filter to specific module |

## Usage
After installation via `sdgpkg install sdg-tips`, three commands become available:

### Show a Random Tip
```bash
sdgtip           # Shortcut: just "sdgtip" defaults to random
tipme            # Alternative alias
```

Displays a random tip from the aggregated collection (all modules' `~/.local/tips/*/tips.list` files). Supports optional filtering:
```bash
sdgtip random --from SDG-TIPS   # Random tip from a specific module only
```

### Browse All Tips
```bash
alltips          # Opens fzf list of all tips
sdgtip list      # Same, with explicit command
sdgtip list --from SDG-DOCS     # Filter to specific module
```

### Manage Tip Sources
```bash
sdgtip sources   # List all modules contributing tips with counts
```

### Exclude Annoying Modules
```bash
sdgtip config exclude add SDG-FETCH       # Stop seeing fetch tips
sdgtip config exclude remove SDG-FETCH    # Re-include them
sdgtip config exclude list               # See current exclusions
```

Exclusions are stored in `~/.config/SDG-TIPS/config.toml`.

### Keybind Integration
- `SUPER+0` — bound to `sdgtip random` (from SDG-MANGO-CORE binds.conf)
- Terminal startup — SDG-TERM's Ghostty config runs `sdgtip random` on every new terminal

## Directory Structure
```
SDG-TIPS/
├── README.md                     # Placeholder ("readme" only)
├── install.sh / update.sh / uninstall.sh
├── config/SDG-TIPS/
│   └── config.toml               # User exclusion config
├── local/SDG-TIPS/
│   ├── sdg-tips                  # Primary CLI engine (240 lines Bash)
│   ├── tips.sh                   # Legacy engine (dead code)
│   ├── showtip.sh                # Empty stub
│   └── tips.list                 # 167 general tips
├── tips/SDG-TIPS/SDG-TIPS-ABOUT/
│   └── tips.list                 # 6 meta-tips
├── docs/README.md                # Full documentation (49 lines)
├── migration-plan.md             # Migration plan document
├── TESTCOMPLETE.md               # Empty placeholder
├── ANALYSIS.md                   # Alternate internal analysis (207 lines)
```

## Tip Categories (167 total)
- SDG-OS keybindings (SUPER+ shortcuts)
- pacman/package management commands
- Zsh/zoxide tips
- Ghostty terminal tips
- General Linux command tips

## Architecture
```
~/.local/tips/                    # Aggregation point
├── SDG-TIPS/tips.list     (167)  # General tips
├── SDG-DOCS/tips.list     (6)    # Doc tips
├── SDG-FETCH/tips.list    (N)    # Fetch tips (placeholder)
└── ...other modules...
         │
         ▼ find glob
    sdg-tips engine (240 lines)
         │
    random: shuf -n 1
    list:   fzf browser
    sources:find + wc counts
    config: sed TOML edits
```

## Required Dependencies
| Dependency | Purpose |
|------------|---------|
| bash | Runtime |
| shuf (coreutils) | Random selection |
| find (findutils) | Tip file discovery |
| wc (coreutils) | Tip counting |
| sed | Config file editing |
| mktemp (coreutils) | Temp files for config |

## Optional Dependencies
| Dependency | Purpose |
|------------|---------|
| fzf | Interactive list browser |
| cowsay | Fun cow rendering mode |
| lolcat | Rainbow coloring |

## Required Dependents
- **SDG-TERM**: Runs `sdgtip random` on every terminal startup
- **SDG-OS-META**: Installs as `sdg-tips`

## Optional Dependents
- **SDG-UTIL-SCRIPTS**: References `tipme` alias
- **SDG-DOCS**: Documents sdg-tips commands

## Known Issues
- Legacy dead code (`tips.sh`, `showtip.sh` still deployed)
- Wrong state file path (`~/.config/tips.state` should be namespaced)
- Missing `detect.sh`
- Root README is placeholder while real docs in `docs/README.md`
