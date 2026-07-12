# Integration with SDG-DOCS

SDG-TIPS and SDG-DOCS serve complementary roles in the SDG-OS ecosystem.
Understanding when to use each helps keep content discoverable and
maintainable.

## Tips vs Docs

| Aspect | SDG-TIPS | SDG-DOCS |
|--------|----------|----------|
| Length | 1 line each | Pages or sections |
| Purpose | Remind *what* | Explain *how* and *why* |
| Consumption | Rotated randomly or browsed with fzf | Searched or browsed by topic |
| Format | Plain text `.list` files | Markdown `.md` files |
| Delivery | `sdgtip random`, `sdgtip list` | `sdgdocs browse`, `sdgdocs search` |

## When to write a tip vs a doc

**Write a tip when:**
- The information fits in a single sentence
- The user already knows the concept but might forget the shortcut
- You want the information to surface spontaneously via `sdgtip random`

**Write a doc when:**
- The topic needs explanation, examples, or background
- The audience needs step-by-step guidance
- The content is reference material (configuration options, APIs)

## Cross-referencing

Tips can reference docs by name. For example, a tip might say:

> Use 'sdgdocs browse SDG-TERM' to read about terminal configuration

And a doc can mention the tip system:

> For a quick reminder of keybindings, run `sdgtip random --from SDG-WM`.

This keeps both systems lightweight and mutually reinforcing.

## Virtual tip sub-modules

A directory under `tips/MODULE/SUBMODULE/tips.list` is a *virtual tip
sub-module*. It appears as a sub-source in `sdgtip sources` and can be
promoted to a full doc module later without changing any consumer paths.

This makes tips a useful staging ground: start as a tip, grow into a doc
when the topic warrants deeper coverage.
