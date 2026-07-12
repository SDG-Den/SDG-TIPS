# Agent / AI Integration

SDG-TIPS is designed for programmatic consumption. Every command outputs
plain text, making it trivial to use in scripts, agents, and automation.

## Shell init / login

The most common integration is showing a random tip at terminal startup.
Ghostty users add this to `config.ghostty`:

```
initial-command = /bin/zsh -c sdgfetch && echo "" && sdgtip random && zsh
```

The same pattern works in `~/.zshrc` or `~/.bashrc`:

```zsh
# ~/.zshrc
sdgtip random
```

## Desktop notifications

Bind `sdgtip random` to a keybind for on-demand tips. In SDG-OS this is
already wired as `SUPER+0`:

```
SUPER+0 = notify-send "$(sdgtip random)"
```

## Scripts and cron

Use `--from MODULE` to scope tips to a relevant domain:

```bash
# Random networking tip
sdgtip random --from SDG-NET

# Random tip about development
sdgtip random --from SDG-DEV
```

## Module aliases

When invoked by a legacy alias, the CLI auto-selects the right mode:

| Alias | Maps to | Use case |
|-------|---------|----------|
| `tipme` | `sdgtip random` | Quick random tip in a script |
| `alltips` | `sdgtip list` | Interactive fzf browser (needs TTY) |

These are set up by SDG-TERM in `zshconfig.zsh` but work from any shell.

## Excluding modules programmatically

Silence modules that aren't relevant to your context:

```bash
sdgtip config exclude add SDG-OS-THEMES
sdgtip config exclude remove SDG-OS-THEMES
sdgtip config exclude list
```

## Tip source discovery

List all available modules and their tip counts:

```bash
sdgtip sources
```

This is useful for agents to discover what domains are available before
querying.

## Consuming in agents / LLMs

`sdgtip random` returns a single plain-text line. Because the format is
simple and consistent, it can be pulled into agent prompts as inline
context:

```bash
# Agent prompt fragment: include a relevant tip
TIP=$(sdgtip random --from SDG-DEV)
echo "Context: $TIP"
```

The output has no control characters, ANSI codes, or markdown wrapping —
just the raw tip text.

## Planned

- `--format json` — structured output for machine parsing
- `--format full` — detailed tips with metadata
