# SDG-TIPS Migration Plan

## Directory Mapping

| Source | Installed to |
|--------|-------------|
| `local/SDG-TIPS/tips.sh` | `~/.local/SDG-TIPS/tips.sh` |
| `local/SDG-TIPS/tips.list` | `~/.local/tips/SDG-TIPS/tips.list` |
| `tips/` | `~/.local/tips/SDG-TIPS/` |
| `docs/` | `~/.local/docs/SDG-TIPS/` |

## Architecture Change

The old design stored tips at `~/.config/sdgos/tips/tips.list` and was referenced via `tips.sh` as a single-file list. The **new architecture** uses **multi-source tip directories**: each module owns `~/.local/tips/<module>/` and the tips engine (`tips.sh`) iterates all `~/.local/tips/*/` directories.

SDG-TIPS itself becomes a **tips module** — it provides a `tips.list` that goes into `~/.local/tips/SDG-TIPS/tips.list` (as one file in the collective pool), plus its own `tips/` directory for additional tip files.

The `tips.sh` engine needs updating to support **multi-directory iteration**:
```bash
for tip_dir in "$HOME/.local/tips"/*/; do
  if [ -f "$tip_dir/tips" ]; then
    tips_list+=("$tip_dir/tips")
  fi
done
```

## Path Rewrites

### tips.sh — internal references

| Old | New |
|-----|-----|
| `TIPS_FILE="$HOME/.config/sdgos/tips/tips.list"` | `TIPS_DIR="$HOME/.local/tips"` (iterate dirs) |
| Single-file mode | Multi-file mode (see above) |

### Cross-module references TO tips.sh

| File | Old | New |
|------|-----|-----|
| SDG-CONF/zshconfig.zsh | `~/.config/sdgos/tips/tips.sh` | `~/.local/SDG-TIPS/tips.sh` |
| SDG-TERM/config.ghostty | `~/.config/sdgos/tips/tips.sh` | `~/.local/SDG-TIPS/tips.sh` |
| SDG-MANGO-CORE/binds.conf | `~/.config/sdgos/tips/tips.list` | `~/.local/tips/SDG-TIPS/tips.list` |
| SDG-MANGO-CORE/plugin_settings.json | `~/.config/sdgos/tips/tips.list` | `~/.local/tips/SDG-TIPS/tips.list` |

## tips.list Content Review

Current `tips.list` contains 11 tips. All are generic. Consider:
- Removing tips about old paths (any mentioning `~/.config/sdgos/`)
- Adding tips explaining the new `~/.local/tips/<module>/` architecture
- Adding tips about the tip system itself

## Lifecycle Scripts

All four root-level scripts are empty. Implement:

- **install.sh**: Copy `local/SDG-TIPS/tips.sh` → `~/.local/SDG-TIPS/tips.sh`, copy `tips.list` → `~/.local/tips/SDG-TIPS/tips.list`, copy `tips/` → `~/.local/tips/SDG-TIPS/`, copy docs.
- **uninstall.sh**: Remove `~/.local/SDG-TIPS/` and `~/.local/tips/SDG-TIPS/`.
- **update.sh**: Re-deploy.
- **detect.sh**: Always succeeds (no external dependencies beyond bash).

## Modular Tips

- `tips/` and `local/tips.list` both go to `~/.local/tips/SDG-TIPS/`

## Modular Docs

- `docs/` is empty — document the tips system, how modules contribute tips, how to add tips.

## Cleanup

- Remove empty `cache/`, `other/`
- Remove empty `tips/` or populate
