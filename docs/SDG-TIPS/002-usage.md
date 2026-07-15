# Usage

## Random tip

```bash
sdgtip                # Random tip from any module
sdgtip random         # Same as above (random is the default command)
tipme                 # Alias for sdgtip random
```

## Filter by module

```bash
sdgtip --from SDG-DOCS     # Random tip from a specific module
sdgtip random --from SDG-DOCS
sdgtip list --from SDG-DOCS # Browse tips from one module
```

## Browse all tips

```bash
sdgtip list            # Interactive fzf browser over all tips
alltips                # Alias for sdgtip list
```

## List sources

```bash
sdgtip sources         # Show all modules with tip counts
```

## Exclude modules

```bash
sdgtip config exclude add SDG-OS-THEMES      # Hide a module
sdgtip config exclude remove SDG-OS-THEMES    # Unhide it
sdgtip config exclude list                    # See exclusions
```

## Fun rendering

```bash
cowtip                 # Random tip with cowsay (if cowsay is installed)
```

## Help

```bash
sdgtip --help          # Show usage summary
sdgtip -h
```
