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

This is **not a fork or a copy** of `emilkowalski/skills`, Anthropic’s skill pack, or any other third-party skill repo.

- We rewrote the skills in our own words for a different stack.
- We **did not** copy large blocks of third-party `SKILL.md` files.
- We **do not** ship React / Motion / Tailwind / npm-library recommendations as defaults.
- Concrete craft numbers (e.g. cubic-bezier curves, duration bands, `scale(0.97)` press feedback) are widely taught in public design-engineering material; when we use them, we treat them as **attributed craft defaults**, not as original invention.

## Our stack philosophy (the deliberate fork)

Where many popular design skills optimize for React product UI (Motion, Base UI, Tailwind, curated npm libraries), this pack optimizes for:

- **Vanilla CSS** (no Tailwind, Sass, or CSS-in-JS as the default)
- **Server-rendered HTML** (templ, Rails, Laravel, plain HTML, etc.)
- **Hypermedia / progressive enhancement** (HTMX, forms, links)
- **Minimal JavaScript** (custom elements, WAAPI) — no React/Vue/Svelte SPA default
- **No animation library** until CSS and WAAPI are proven insufficient

If you want the original React-oriented Emil skills, use: [github.com/emilkowalski/skills](https://github.com/emilkowalski/skills).

## Frontend and admin design influences

The pack’s broader design-taste skills (`frontend-design`, `admin-ui`, shared `visual-craft` / `admin-patterns` references) synthesize durable ideas from widely used public skills and then rewrite them for this stack:

| Source | What we drew from |
| --- | --- |
| [Anthropic `frontend-design`](https://github.com/anthropics/skills/tree/main/skills/frontend-design) | Distinctive direction; ground in subject/audience/job; type as personality; plan-before-code; signature restraint; copy as design material; resisting templated AI aesthetics |
| [Addy Osmani `frontend-ui-engineering`](https://github.com/addyosmani/agent-skills) (and similar production UI guidance) | Anti-AI-aesthetic failure modes; spacing and token discipline; loading/empty/error; production-quality bar (contrast in this pack uses APCA, not WCAG 2 ratios) |
| [APCA / apcacontrast.com](https://apcacontrast.com/) (Myndex) | Polarity-aware perceptual contrast (Lc); Bronze targets by use case; dark-mode-capable readability checks |
| [Dammyjay93 `interface-design`](https://github.com/Dammyjay93/interface-design) | Craft-first product/admin scope; intent-first briefs; hierarchy and density as decisions; subtle surfaces; states as mandatory; operator-focused UI |
| [Impeccable](https://github.com/pbakaus/impeccable) / Paul Bakaus | Brand (persuade) vs product (operate) mode split so marketing and tools do not share one aesthetic vocabulary |

We do **not** vendor those repositories. Agents should not expect their command names, file ceremonies, or React/Tailwind recipes here.

## Additional influences

| Source | Notes |
| --- | --- |
| Apple WWDC *Designing Fluid Interfaces* (2018) and related design talks | Fluid motion, interruptibility, springs — also cited in Emil's and many industry notes |
| 37signals / Basecamp frontend practice | HTML-first, vanilla-is-plenty, progressive enhancement |
| Project conventions from hypermedia apps (templ, HTMX, progressive enhancement) | Token CSS, custom elements, HTMX partials |
| [Jakub Antalík / transitions.dev](https://github.com/Jakubantalik/transitions.dev) | Catalog of common UI transition *jobs* (dropdown, modal, toast, tabs, …) and the idea of matching motion to usage rather than nearest numbers. This pack **does not** vendor that repo, its `t-*` snippets, npm CLI, or Refine panel. `ui-transitions` and `polish-transitions` rewrite the catalog against this pack’s stack ladder and [motion-tokens.md](./references/motion-tokens.md). |

## How to credit this pack

If you reuse or adapt **this** repository:

1. Keep this `ATTRIBUTION.md` (or an equivalent notice).
2. Keep our `LICENSE` copyright notice.
3. Continue to credit Emil Kowalski for the design-engineering and motion ideas this pack builds on.
4. When you reuse our frontend/admin synthesis, keep credit for the sources listed above as inspirations.

Suggested one-liner for a README or skill header:

> Design taste, admin UI craft, and motion rules inspired by [Emil Kowalski](https://emilkowal.ski/), popular public frontend/admin skills, and rewritten for vanilla CSS and server-rendered hypermedia in [vanilla-design-taste](https://github.com/raybarrera/vanilla-design-taste).
