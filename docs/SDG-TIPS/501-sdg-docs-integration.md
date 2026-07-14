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
| Delivery | `sdgtip random`, `sdgtip list` | Documentation browser |

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

> Use the documentation system to read about terminal configuration

And a doc can mention the tip system:

> For a quick reminder of keybindings, run `sdgtip random --from SDG-WM`.

This keeps both systems lightweight and mutually reinforcing.


