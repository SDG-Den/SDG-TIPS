# SDG-TIPS — Repository Analysis

## Function

SDG-TIPS is the tip/advice system for SDG-OS. It aggregates `.list` tip files
from every installed module's `~/.local/tips/<MODULE>/` directory and displays
them on demand.  Users get a random tip at terminal startup (via Ghostty
`initial-command`, SDG-TERM/other/zshconfig.zsh:7), on-demand via `sdgtip`
(`/usr/bin/sdgtip`), or through the legacy aliases `tipme` (random) and
`alltips` (fzf browser).

Three symlinks are created at install time:
- `/usr/bin/sdgtip` → `~/.local/SDG-TIPS/sdg-tips` (primary CLI)
- `/usr/bin/tipme` → `~/.local/SDG-TIPS/sdg-tips` (same binary; `basename $0` triggers `random`)
- `/usr/bin/alltips` → `~/.local/SDG-TIPS/sdg-tips` (same binary; `basename $0` triggers `list`)

---

## Files

### Root-level lifecycle scripts

| File | Status | Path |
|------|--------|------|
| `install.sh` | Implemented | `install.sh` |
| `uninstall.sh` | Implemented | `uninstall.sh` |
| `update.sh` | Implemented | `update.sh` |
| `detect.sh` | **MISSING** | does not exist |

`install.sh` deploys:
- `local/SDG-TIPS/sdg-tips` → `~/.local/SDG-TIPS/sdg-tips` (chmod +x, line 7)
- `local/SDG-TIPS/tips.list` → `~/.local/tips/SDG-TIPS/tips.list` (line 10)
- `tips/SDG-TIPS/` → `~/.local/tips/SDG-TIPS/` (line 11)
- `docs/` → `~/.local/docs/SDG-TIPS/` (line 14)
- `config/SDG-TIPS/config.toml` → `~/.config/SDG-TIPS/config.toml` (only if absent, line 17)
- Symlinks: `sdgtip` (line 19), `tipme` (line 20), `alltips` (line 21)

`uninstall.sh` removes all deployed paths and symlinks. Also removes
`~/.config/tips.state` (line 6).

`update.sh` re-deploys engine, tips, and docs (same as install but skips config
so user exclusions survive).  **Notable**: does not re-link if symlinks are
broken — assumes they still exist from install.

`detect.sh` does **not exist**.  Referenced in `migration-plan.md` line 59 as
"Always succeeds (no external dependencies beyond bash)" but never created.

### Engine files under `local/SDG-TIPS/`

| File | Lines | Status |
|------|-------|--------|
| `sdg-tips` | 240 | **Active CLI engine** |
| `tips.sh` | 41 | **Dead code** (legacy engine, still deployed) |
| `showtip.sh` | 3 | **Empty stub** (no functionality) |
| `tips.list` | 168 | Primary tip collection (167 non-empty lines + trailing newline) |

#### `local/SDG-TIPS/sdg-tips` (active engine)

- **Line 3**: `CONFIG_FILE="$HOME/.config/SDG-TIPS/config.toml"`
- **Line 4**: `TIPS_DIR="$HOME/.local/tips"`
- **Line 5**: `STATE_FILE="$HOME/.config/tips.state"` ← **old path** (see CRITICAL below)
- Lines 212-215: Invocation dispatch via `basename $0` — if invoked as `tipme` → random, `alltips` → list
- Lines 68-89: `cmd_random` — uses `shuf -n 1` to pick a random tip; cowsay/lolcat rendering if state says "cow"
- Lines 91-101: `cmd_list` — pipes tips into `fzf --layout=reverse`
- Lines 103-139: `cmd_sources` — iterates `TIPS_DIR/*/`, counts `.list` files, prints table
- Lines 141-207: `cmd_config` — manages `[exclude] sources = [...]` in config.toml

**Commands**:
```
sdgtip [random] [--from MODULE]        random tip
sdgtip list [--from MODULE]            fzf browser
sdgtip sources                         source counts table
sdgtip config exclude {add|remove|list} [MODULE]
```

**Optional runtime dependencies**: `fzf` (list mode), `cowsay` + `lolcat` (cow mode)

#### `local/SDG-TIPS/tips.sh` (dead code)

- Still references the **old** monolithic tip path `~/.config/sdgos/tips/tips.list` (lines 15, 38-39)
- Still uses the **old** state path `~/.config/tips.state` (lines 3-4, 7, 25, 28, 33, 38)
- Has no multi-directory iteration — reads a single file
- The `migration-plan.md` (lines 14, 18) assumes this is the active engine and describes refactoring it, but the refactor was done by creating `sdg-tips` instead — `tips.sh` was never deleted

#### `local/SDG-TIPS/showtip.sh` (empty stub)

3 lines, shebang only. No logic. Appears to be an abandoned artifact.

### Tip data files

| File | Lines | Content |
|------|-------|---------|
| `local/SDG-TIPS/tips.list` | 168 | 167 tips (keybindings, pacman, zsh, general Linux) |
| `tips/SDG-TIPS/SDG-TIPS-ABOUT/tips.list` | 6 | Tips about using `sdgtip` itself |

The `tips/SDG-TIPS/SDG-TIPS-ABOUT/` directory is a **virtual tip sub-module** —
a subdirectory that can be split into its own repo later without changing paths.

### Documentation

| File | Status |
|------|--------|
| `README.md` | Placeholder — single word `readme` |
| `docs/README.md` | 49 lines — actual documentation of the tips system |
| `TESTCOMPLETE.md` | Empty |

### Config

| File | Content |
|------|---------|
| `config/SDG-TIPS/config.toml` | `[exclude]` section with empty `sources = []` |

---

## Dependencies

| Dependency | Required | Versions | Used In |
|-----------|----------|----------|---------|
| `bash` | Yes | Any | Shebang of all scripts |
| `shuf` (coreutils) | Yes | Any | `sdg-tips:80` |
| `find` (findutils) | Yes | Any | `sdg-tips:61,122,135` |
| `wc` (coreutils) | Yes | Any | `sdg-tips:65,93,128,135` |
| `sed` | Yes | Any | `sdg-tips:32,157,169,187` |
| `mktemp` (coreutils) | Yes | Any | `sdg-tips:156,174` |
| `realpath/dirname` (coreutils) | Yes | Any | `sdg-tips:47-48,115` |
| `fzf` | No (list mode) | Any | `sdg-tips:100` |
| `cowsay` | No (cow mode) | Any | `sdg-tips:83` |
| `lolcat` | No (cow mode) | Any | `sdg-tips:83` |
| `sudo` | Yes (install/uninstall) | Any | `install.sh:19-21`, `uninstall.sh:8-10` |

---

## Dependents (consumers of SDG-TIPS)

| Repository | File(s) | Reference | Usage |
|-----------|---------|-----------|-------|
| **SDG-OS-META** | `install.sh:8` | `sdgpkg install sdg-tips` | Pulls SDG-TIPS as a dependency during `sdgpkg install` of the full OS |
| **SDG-TERM** | `other/zshconfig.zsh:26-28` | `alias tipme='~/.local/SDG-TIPS/sdg-tips random'` / `alias alltips='~/.local/SDG-TIPS/sdg-tips list'` / `alias cowtip='...'` | Zsh aliases for end-user access |
| **SDG-TERM** | `config/ghostty/config.ghostty:7` | `initial-command = /bin/zsh -c sdgfetch && echo "" && sdgtip random && zsh` | Shows random tip on every new terminal |
| **SDG-DOCS** | Multiple files | Documentation of `sdgtip` commands, paths (`/usr/bin/sdgtip`, `~/.local/tips/`, `~/.config/SDG-TIPS/config.toml`) | Agent docs, dev docs, new-user docs, tinkerer docs |
| **SDG-UTIL-SCRIPTS** | Multiple help topics | References to `tipme`, `SUPER+0` for random tip | User-facing help content |

---

## CRITICAL Issues

### 1. `tips.sh` is dead code still deployed

`local/SDG-TIPS/tips.sh:1-41` is the **legacy engine**. It reads
`~/.config/sdgos/tips/tips.list` (old pre-migration path) and
`~/.config/tips.state`.  The migration was supposed to update this script
(per `migration-plan.md:18,29`) but instead a **new engine**
(`sdg-tips`) was written from scratch.  `tips.sh` was never removed and is
still copied to `~/.local/SDG-TIPS/tips.sh` by `install.sh:6`.  It is
**unused** — no consumer references it now; the aliases in
`zshconfig.zsh:26-28` point to `sdg-tips` directly.

### 2. State file at `~/.config/tips.state` — wrong location

Both `sdg-tips:5` and the legacy `tips.sh` (multiple lines) read/write
`STATE_FILE="$HOME/.config/tips.state"`.  This is the **old pre-migration
path**.  The `GLOBAL-MIGRATION-GUIDE.md:160` explicitly says it should have
been moved to `~/.local/SDG-TIPS/tips.state`.  This means:

- State file persists after `uninstall.sh` (it only removes `~/.config/tips.state` as a clean-up, line 6 — acknowledgement it's misplaced)
- Not namespaced under `~/.config/SDG-TIPS/` like the config toml

### 3. `showtip.sh` is an empty stub

`local/SDG-TIPS/showtip.sh:1-3` — just a shebang and blank lines.
No logic, no callers, no purpose.  Should be removed or implemented.

### 4. `detect.sh` is missing

Referenced in `migration-plan.md:59` as a required lifecycle script ("Always
succeeds"), but no file exists at the root of the repo.

### 5. `migration-plan.md` has multiple inaccuracies

| Claim | File / Line | Reality |
|-------|-------------|---------|
| "Current `tips.list` contains 11 tips" (`migration-plan.md:47`) | `local/SDG-TIPS/tips.list` | Contains **168 lines** (167 tips + trailing newline) |
| "All four root-level scripts are empty" (`migration-plan.md:54`) | Root dir | `install.sh`, `uninstall.sh`, `update.sh` are **fully implemented** (23, 10, 20 lines); only `detect.sh` is missing |
| Plan assumes `tips.sh` needs multi-directory refactor (`migration-plan.md:14,18,29`) | `local/SDG-TIPS/tips.sh` | Refactor was done as a **new script** (`sdg-tips`); `tips.sh` was abandoned, not updated |
| "`tips.sh` engine" heading in migration references | Throughout | The actual engine is `sdg-tips`, not `tips.sh` |

### 6. `README.md` is a placeholder

Contains only the word `readme` — no documentation at root level (the actual
docs are in `docs/README.md`).

### 7. `TESTCOMPLETE.md` is empty

Zero bytes. No test results or completion status.

---

## Deprecation / Outdated Items

| Item | File | Reason |
|------|------|--------|
| `tips.sh` | `local/SDG-TIPS/tips.sh` | Legacy engine; superseded by `sdg-tips` |
| `showtip.sh` | `local/SDG-TIPS/showtip.sh` | Empty stub, never implemented |
| `~/.config/tips.state` | `sdg-tips:5` | Old path; should be `~/.local/SDG-TIPS/tips.state` or `~/.config/SDG-TIPS/tips.state` |
| Old sync of config on update | `update.sh:6` | Pulls `local/SDG-TIPS/*` which includes `tips.sh` and `showtip.sh` (dead files) |
| `README.md` | Root | Placeholder; replace with cross-reference to `docs/README.md` |
| `TESTCOMPLETE.md` | Root | Empty; remove or populate |
