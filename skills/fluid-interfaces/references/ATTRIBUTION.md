# Attribution

## Primary inspiration

This skill pack is **inspired by** the public design-engineering and animation teaching of **[Emil Kowalski](https://emilkowal.ski/)**, including:

| Source | What we drew from |
| --- | --- |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) (MIT) | Skill shapes (build / review / audit / find / vocabulary), review tables, frequency gates, "cheapest tool" ladders |
| [animations.dev](https://animations.dev/) | Motion craft, taste training for agents and engineers |
| [Agents with Taste](https://emilkowal.ski/ui/agents-with-taste) | Why agents need explicit craft rules |
| [7 Practical Animation Tips](https://emilkowal.ski/ui/7-practical-animation-tips) | Easing choices, duration intuition |
| [You Don't Need Animations](https://emilkowal.ski/ui/you-dont-need-animations) | Restraint: most candidates should not animate |
| Emil's component work (e.g. [Sonner](https://sonner.emilkowal.ski/), [Vaul](https://vaul.emilkowal.ski/)) | Good defaults, interruptible transitions, spatial consistency |

Emil's original skills are MIT-licensed (Copyright (c) 2026 Emil Kowalski). See his [LICENSE](https://github.com/emilkowalski/skills/blob/main/LICENSE).

## What this pack is not

This is **not a fork or a copy** of `emilkowalski/skills`.

- We rewrote the skills in our own words for a different stack.
- We **did not** copy large blocks of his `SKILL.md` files.
- We **do not** ship his React / Motion / Tailwind / npm-library recommendations.
- Concrete numbers (e.g. cubic-bezier curves, duration bands, `scale(0.97)` press feedback) are widely taught in his public material; when we use them, we treat them as **attributed craft defaults**, not as original invention.

## Our stack philosophy (the deliberate fork)

Where Emil's pack optimizes for modern React product UI (Motion, Base UI, curated npm libraries), this pack optimizes for:

- **Vanilla CSS** (no Tailwind, Sass, or CSS-in-JS as the default)
- **Server-rendered HTML** (templ, Rails, Laravel, plain HTML, etc.)
- **Hypermedia / progressive enhancement** (HTMX, forms, links)
- **Minimal JavaScript** (custom elements, WAAPI) — no React/Vue/Svelte SPA default
- **No animation library** until CSS and WAAPI are proven insufficient

If you want the original React-oriented skills, use Emil's pack: [github.com/emilkowalski/skills](https://github.com/emilkowalski/skills).

## Additional influences

| Source | Notes |
| --- | --- |
| Apple WWDC *Designing Fluid Interfaces* (2018) and related design talks | Fluid motion, interruptibility, springs — also cited in Emil's and many industry notes |
| 37signals / Basecamp frontend practice | HTML-first, vanilla-is-plenty, progressive enhancement |
| Project conventions from hypermedia apps (templ, HTMX, progressive enhancement) | Token CSS, custom elements, HTMX partials |
| [Jakub Antalík / transitions.dev](https://github.com/Jakubantalik/transitions.dev) | Catalog of common UI transition jobs; rewritten here as `ui-transitions` / `polish-transitions` (pack tokens, no `t-*` snippets, CLI, or Refine panel) |

## How to credit this pack

If you reuse or adapt **this** repository:

1. Keep this `ATTRIBUTION.md` (or an equivalent notice).
2. Keep our `LICENSE` copyright notice.
3. Continue to credit Emil Kowalski for the design-engineering ideas this pack builds on.

Suggested one-liner for a README or skill header:

> Motion and UI craft rules inspired by [Emil Kowalski](https://emilkowal.ski/) and [emilkowalski/skills](https://github.com/emilkowalski/skills); rewritten for vanilla CSS and server-rendered hypermedia in [vanilla-design-taste](https://github.com/raybarrera/vanilla-design-taste).
