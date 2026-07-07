# SDG-TIPS Migration Plan

## 1. Implement Lifecycle Scripts

All four root-level lifecycle scripts are **empty stubs** — must be implemented:

| Script | Purpose |
|--------|---------|
| `install.sh` | Deploy `local/SDG-TIPS/tips.sh` → `~/.config/sdgos/tips/tips.sh`, deploy `local/SDG-TIPS/tips.list` → `~/.config/sdgos/tips/tips.list`, deploy `local/SDG-TIPS/showtip.sh` → `~/.config/sdgos/tips/showtip.sh` |
| `uninstall.sh` | Remove `~/.config/sdgos/tips/`, remove `~/.config/tips.state` (user preference) |
| `update.sh` | Overwrite tips.sh and tips.list (showtip.sh if improved) |
| `detect.sh` | Check for `shuf`, `cowsay`, `lolcat` (optional deps for cow mode) |

## 2. Path Audit

### 2.1 `tips.sh` references
- Line 3: `~/.config/tips.state` — state file in top-level `~/.config/` (not under sdgos). Consider moving to `~/.config/sdgos/tips/tips.state` for consistency.
- Line 17: `~/.config/sdgos/tips/tips.list` — correct.
- Line 20: `~/.config/sdgos/tips/tips.list` — correct.

### 2.2 `showtip.sh`
- Currently just a shebang — needs implementation. What should it do differently from `tips.sh`?

### 2.3 No hardcoded `/home/$(whoami)/` paths found — good.

## 3. Cross-module References

### 3.1 SDG-TERM references this module
- `config/ghostty/config.ghostty` line 7: runs `tips.sh` on terminal launch.
- `other/zshconfig.zsh` lines 26-28: `tipme`, `alltips`, `cowtip` aliases.

### 3.2 SDG-MANGO-CORE references this module
- `config/mango/binds.conf` line 6: `SUPER+0` → `shuf -n 1 ~/.config/sdgos/tips/tips.list`.
- `config/DankMaterialShell/plugin_settings.json` lines 33-43: DMS panel shows random tip.

### 3.3 SDG-UTIL-SCRIPTS references this module
- `local/SDG-HELP/topics/002` and `004` describe the tips system.

## 4. Modular Tips System — Architecture

### 4.1 Problem
Currently there is **no mechanism** for other modules to contribute their own tips. All tips live in SDG-TIPS' `tips.list`. Other modules that want to add tips must either:
1. Append to `~/.config/sdgos/tips/tips.list` during their own install (error-prone, conflicts).
2. Be ignored — tips stay centralized.

### 4.2 Solution: Multi-source tip aggregation
Modify `tips.sh` to read from multiple sources:

```bash
# Ordered list of tip sources (directories with tips.list files)
TIPS_DIRS=(
  "$HOME/.config/sdgos/tips"           # SDG-TIPS core
  "$HOME/.config/sdgos/tips/modules"   # Other modules contribute here
)
```

**New installation convention:**
- Each module can place `tips.list` in its `tips/` directory.
- When a module is installed via `sdgpkg install`, the SDG-PKG lifecycle should:
  1. Copy the module's `tips/` contents to `~/.config/sdgos/tips/modules/<module-name>/tips.list`.
  2. Or, append the module's tip lines to a merged file.

**Approach A — Directory merge (recommended):**
```
~/.config/sdgos/tips/tips.list                  # Core tips (SDG-TIPS)
~/.config/sdgos/tips/modules/SDG-FETCH/tips    # SDG-FETCH tips file
~/.config/sdgos/tips/modules/SDG-TERM/tips     # SDG-TERM tips file
~/.config/sdgos/tips/modules/SDG-MANGO-CORE/tips # MANGO-CORE tips
```
Modify `tips.sh` to concatenate all files with `cat ~/.config/sdgos/tips/*/tips` and pipe to `shuf -n 1`.

**Approach B — Install-time concatenation:**
Each module's `install.sh` appends its tips to `~/.config/sdgos/tips/tips.list`. Simpler but messier.

### 4.3 Implementation steps for tips.sh
1. Change line 17 from: `shuf -n 1 ~/.config/sdgos/tips/tips.list`
2. To: `find ~/.config/sdgos/tips -name 'tips.list' -o -name 'tips' | xargs cat | shuf -n 1`

## 5. Modular Help System Integration

### 5.1 Add help command for tips
- `tips.sh --help` should show usage info.
- Consider contributing a help topic about the tips system itself.

## 6. Empty Directory Cleanup

| Directory | Status |
|-----------|--------|
| `cache/` | Empty — remove |
| `tips/` | Empty — this is where module-specific tips should go (contradicts the name; rename to `contrib/` or populate) |
| `config/` | Empty — remove |
| `other/` | Empty — remove |

## 7. Cross-package tips
- SDG-TIPS' `tips.list` currently contains tips about SDG-TERM and SDG-MANGO-CORE features.
- After modularization, those modules should own their own tips, and SDG-TIPS should only contain generic SDG-OS tips.
- Migration: move terminal tips to SDG-TERM, mangoWM/DMS tips to SDG-MANGO-CORE, etc.
