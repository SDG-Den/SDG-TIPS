# SDG-TIPS

The SDG-OS tips system — display random tips and guidance from all installed modules.

## Description

SDG-TIPS aggregates tip files from every module's `~/.local/tips/<MODULE>/` directory and provides a CLI engine for displaying them. It ships with a general tip collection plus module-specific tips from each installed package.

## Features

- **Random tip** — `sdgtip` or `tipme` shows a random tip
- **Browse all tips** — `alltips` or `sdgtip list` opens fzf browser
- **Module filter** — `sdgtip --from MODULE` scopes to one source
- **Source listing** — `sdgtip sources` shows modules with tip counts
- **Module exclusion** — `sdgtip config exclude <add|remove> <module>` to hide modules
- **Keybind** — SUPER+0 bound to `sdgtip random` (from SDG-MANGO-CORE)
- **Terminal startup** — SDG-TERM runs `sdgtip random` on every new terminal
- **Fun rendering** — `cowtip` for cowsay mode, `lolcat` for rainbow coloring

## CLI Usage

```bash
sdgtip                        # Random tip from any module
sdgtip random --from SDG-DOCS  # Random tip from a specific module
sdgtip list                   # Browse all tips in fzf
sdgtip sources                # List all modules with tip counts
tipme                         # Shorthand for random tip
alltips                       # Shorthand for list
cowtip                        # Random tip with cowsay
```

## Installation

```bash
sdgpkg install sdg-tips
```

## Dependencies

- `bash` — runtime
- `shuf` (coreutils) — random selection
- `find` (findutils) — tip file discovery
- `fzf` (optional) — interactive list browser
- `cowsay`, `lolcat` (optional) — fun rendering

## Related Packages

- **SDG-DOCS** — companion documentation system
- **SDG-TERM** — runs tips on startup, provides aliases
- **SDG-MANGO-CORE** — binds SUPER+0 to tips
