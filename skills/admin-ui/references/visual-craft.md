# Visual Craft

Shared visual design doctrine for this pack. Stack law still lives in [stack.md](./stack.md). Motion numbers live in [motion-tokens.md](./motion-tokens.md).

**Attribution:** Anti-slop patterns and distinctive-direction discipline draw from public frontend design skills (notably Anthropic `frontend-design` and production-floor guidance in community UI engineering skills). Brand-vs-product mode separation draws from the Impeccable-style operate/persuade split. Product hierarchy and density craft draw from craft-first interface design practice (e.g. Dammyjay93 `interface-design`). See [ATTRIBUTION.md](./ATTRIBUTION.md) (pack root or skill `references/`). All of the below is rewritten for **vanilla CSS + server-rendered HTML**.

## Prefer project systems first

If the host app already defines surfaces, type ramps, spacing, and radii — **use those**. Extend tokens; do not invent a parallel palette beside a working system.

## Brand vs product modes

Name the mode before designing. A landing page and a dashboard live by contradictory rules.

| Mode | Surfaces | Goal | Expression budget | Motion |
| --- | --- | --- | --- | --- |
| **Brand** (persuade) | Marketing, landing, portfolios, campaigns | Decide and act | Higher: signature type, bold layout, one memorable moment | Occasional explanatory or delight (still purposeful) |
| **Product** (operate) | App chrome, tools, settings, most SaaS screens | Complete a task | Lower: scanability and consistency beat flourish | Mostly feedback and state; high-frequency = little/none |
| **Admin** (operate, dense) | Dashboards, CRMs, internal tools, data tables | Find, filter, act on records | Lowest decorative budget; density and hierarchy are the craft | Almost none on chrome; use the `admin-ui` skill and its `admin-patterns` reference |

- Pick mode from the **surface**, not the company brand book alone. A tool’s marketing site is still Brand; a fashion house’s order admin is still Admin.
- Never apply Brand maximalism to Admin density, or Admin flatness to a Brand hero.

## Anti-slop (defaults to refuse)

AI-generated UI clusters. Unless the brief *asks* for one of these, do not ship them as the default look:

| Pattern | Why it fails | Prefer |
| --- | --- | --- |
| Purple / indigo gradients everywhere | Training-data “safe” palette | Host brand tokens or a domain-derived palette |
| Inter / Roboto / Arial / Space Grotesk as the only personality (Brand mode) | Generic SaaS face | Deliberate display + body pairing for *this* subject (Product/Admin may use system UI stacks) |
| Cream page + terracotta accent + high-contrast serif (unmotivated) | Current median AI marketing look | Palette from the subject’s world |
| Near-black + single acid green / vermilion (unmotivated) | Same | Domain color, not a template |
| Uniform 2×2 / 3×3 card grids as the whole layout | Parking-lot hierarchy | Content-led structure; one focal task |
| `rounded-2xl` / maximum rounding on everything | No radius scale | Small / medium / large radius tokens by role |
| Oversized equal padding on every box | Destroys hierarchy | Spacing scale + uneven rhythm (tight groups, air between groups) |
| Shadow stacks on every card | Noise and cost | One depth strategy (borders *or* subtle shadow *or* surface shift) |
| Lorem / fake metrics | Hides overflow and wrapping | Realistic copy and numbers |
| Color as the only status signal | Fails a11y | Icon + text + color |

**Litmus:** If another model given a similar prompt would produce substantially the same UI, you have defaulted. Revise until direction is specific to *this* subject and mode.

## Hierarchy

1. **One focal point per view.** Name it. Make it win with size, weight, contrast, or space. Demote the rest.
2. **Weight and color do more than size mush.** Same 14px can hold three tiers: strong primary / medium secondary / muted meta.
3. **Type scale is a ratio**, not vibes. Dense product ~1.2; most product ~1.25; expressive Brand ~1.333. Round to whole px and the spacing grid.
4. **Text roles (four levels):** primary, secondary, tertiary, muted. Using only two is usually too flat.
5. **~60 / 30 / 10:** dominant neutral surface, secondary tone, scarce accent. Color *means* (status, action, identity); gray builds structure.
6. **Squint test:** blur the UI — hierarchy still readable, nothing harsh jumps out.

### Metric example (product / admin)

| Flat | Decided |
| --- | --- |
| Label and value same size/weight/gray | Label: small, medium weight, muted, tracked; value: large, semibold, primary, `tabular-nums`; delta: small success/danger |

## Density

Density is a **named decision**, then held constant for that surface.

| Feel | Typical component padding | Use when |
| --- | --- | --- |
| Tool-tight | 8–12px | Admin tables, dense tools, power users |
| Product-default | 12–16px | Everyday SaaS app chrome |
| Airy | 20–28px | Marketing sections, onboarding calm |

Do not mix tool-tight and brochure-airy on the same screen without a reason (e.g. dense table inside a calmer page frame).

## Spacing

- Base unit **4px or 8px** (match host). Multiples only — no `13px` one-offs.
- Scale by context: micro (icon gaps) → component → section → major regions.
- Related things sit close; unrelated groups get real air. Monotone equal gaps read as “no one decided.”

## Surfaces and depth

Pick **one** depth strategy and commit:

| Strategy | Fits |
| --- | --- |
| Borders only | Dense tools, technical admin |
| Subtle shadow | Approachable product cards |
| Layered shadow | Premium Brand moments (rare in admin) |
| Surface lightness steps | Quiet elevation without shadows |

Rules:

- Elevation steps are **whisper-quiet** (few % lightness or soft shadow). Dramatic jumps look broken.
- **Sidebars:** same background as canvas + subtle border — not a second “sidebar world” color.
- **Inputs:** slightly inset (often a touch darker than surroundings), not raised like buttons.
- **Borders:** low-opacity edges that disappear until you look for structure; solid harsh hex lines are a last resort.
- Nested radii: `outer ≈ inner + padding` (concentric), not the same radius on parent and child.

## Typography

- **Brand:** display face with restraint + readable body; type treatment can be part of the signature.
- **Product / Admin:** system UI stack or host font is fine; hierarchy from weight/size/color matters more than novelty.
- Headings: slightly tighter tracking as size grows; body line-height ~1.4–1.6.
- Dynamic numbers (tables, KPIs, timers): `font-variant-numeric: tabular-nums`.
- `text-wrap: balance` on short headings when supported; avoid orphan-heavy marketing lines.

## Color tokens (semantic)

Prefer roles over raw hex in components:

```text
--surface-page / --surface-raised / --surface-inset
--content-primary / --content-secondary / --content-muted
--border-subtle / --border-strong
--accent / --accent-contrast
--danger / --warning / --success
--focus-ring
```

- Extend host names if they already exist.
- Dark mode: prefer borders over deep shadows; keep one hue family and shift lightness.
- Contrast: aim WCAG AA (4.5:1 normal text, 3:1 large / UI chrome).

## Accessibility floor

- Real controls: `<button>`, `<a href>`, labeled inputs — not `<div onclick>`
- Keyboard: every action reachable; visible `:focus-visible`
- Prefer native `<dialog>`, `<details>`, form validation where they fit
- Do not rely on color alone for state
- Hit targets: aim 44×44px; if the glyph is smaller, expand the hit area
- Honor `prefers-reduced-motion` (see motion-tokens)
- Gate hover-only motion with `(hover: hover) and (pointer: fine)`

## States (not optional)

Every interactive control: default, hover (fine pointer), active, focus-visible, disabled.  
Every data region: loading, empty (with next action), error (with recovery).

Missing states are the fastest “unfinished” tell.

## Copy as design material

- Name controls by what the **user** does (“Save changes”), not system jargon
- Active voice; sentence case; same action name through the flow
- Errors: what failed + how to fix — no vague apology
- Empty: invite the next step, not a dead end

## Implementation posture (this stack)

- Semantic HTML + server templates; smallest HTMX partial that swaps cleanly
- Static presentation in classes + custom properties — not long inline style soup
- **No JS by default** — see [stack.md](./stack.md) affordances ladder. Prefer `popover`, `:has()`, forms, and CSS motion over classList scripts
- Native control → host partial → (only if needed) small custom element — never invent a client SPA for chrome
- Animate only when motion-tokens allow; Brand motion prefers CSS (`@starting-style`, view timelines, hover) over IntersectionObserver

## Wow without slop (elevation bar)

Correct structure alone often still looks **flat**. “Wow” is not more decoration — it is **one bold, domain-true decision executed with optical precision**. If the page is tidy but forgettable, you under-committed on signature and over-smoothed everything else.

### Elevation levers (pick 2–3, not all)

| Lever | Brand (landing / marketing) | Product / Admin |
| --- | --- | --- |
| **Material** | Paper grain, chalk, metal, film grain, ink bleed — from the subject’s world | Quiet materials: hairline rules, inset fields, same-hue elevation |
| **Type drama** | Display size jump (display 40–72px), italic or weight contrast on **one** phrase | Hierarchy via weight/opacity; rarely a display face |
| **Asymmetry** | Uneven columns, overlapping frame, editorial crop | Steady grid; asymmetry only in empty/hero zero-states |
| **Depth** | One premium stack (soft layered shadow **or** perspective frame) | Borders / 1-step surface shift; no floating marketing cards |
| **Light** | Controlled wash, vignette, or section ink band | Even, work-light; accent only on status/action |
| **Motion** | CSS hero entrance + optional CSS scroll/view timelines; hover lift on CTAs — **no JS by default** | Press scale, focus, dialog/popover enter; **no** page choreography |
| **Detail density** | Fewer elements, each finished (rules, captions, optical align) | More data, each legible (tabular nums, sticky head, states) |

### Signature test (required for Brand)

Name the **one** thing a stranger would remember in five seconds. Examples that pass: ruled gradebook ground + serif thesis; chalk-green ink band with a floating product frame; a single oversized metric as the hero.

Fail: “clean layout with teal buttons,” “nice cards,” “subtle gradients everywhere.”

### Material specificity

Do not stop at hex values. Describe **finish**:

- Warm uncoated paper vs cold blue-white app chrome  
- Soft chalk dust vs hard enamel  
- Brass rule vs plastic divider  

Encode finish in CSS: grain (`repeating-linear` / SVG noise), rule rhythm, border opacity, background attachment, section band contrast. Generic “off-white + accent” is incomplete.

### Optical polish checklist

- Nested radii: `outer ≈ inner + padding`  
- Icon/text optical centering (nudge play triangles, balance icon buttons)  
- `text-wrap: balance` on display; `pretty` on body when supported  
- Tabular nums on every dynamic number  
- Hairline separators at ~6–12% ink, not solid gray bars  
- Hover gated with `(hover: hover) and (pointer: fine)`  
- Focus-visible rings that match accent, 2px + offset  
- Press feedback `scale(0.97–0.98)` on primary actions  
- No accidental equal padding on hero, section, and footer (rhythm must vary)

### Brand motion budget (vanilla)

| Moment | Allowed | Avoid |
| --- | --- | --- |
| First paint hero | CSS `@keyframes` / `@starting-style` stagger (no JS) | Endless float loops on copy; IO script for simple fades |
| Scroll | CSS scroll-driven / view timelines when supported; otherwise static is fine | Requiring JS to “unlock” content visibility |
| CTA / links | Color + 1–2px translate or shadow on hover | Scale bounce on every link |
| Product frame | Subtle lift or sheen on hover (fine pointer) | Continuous 3D spin |

Always honor `prefers-reduced-motion`: keep opacity fades, drop travel. Do not add a script only to polyfill decorative motion.

### Product / Admin “wow”

Operators feel quality as **competence**, not spectacle:

- Instant press feedback; keyboard-visible focus  
- Selection and bulk bars that appear without layout jump (reserved space or stable height)  
- Empty/error states with a clear next action and a touch of domain illustration (CSS/SVG, not stock art)  
- At-risk / attention rows that are scannable (left rule, tint) without screaming  
- Command-style search or filter that feels like a tool, not a form from 2009  
- Dense tables that still breathe: consistent column rhythm, sticky header, no mystery icon-only actions  

If admin “wow” needs marketing motion, you are in the wrong mode — hand off to Brand surfaces.

### Anti-flat self-critique

Before shipping, answer:

1. What is the signature? (one sentence)  
2. Where did we spend boldness? (one place)  
3. What material/finish is visible in the CSS?  
4. Would a screenshot still be recognizable without the logo?  
5. Did we use motion only where purpose is named?

If (1) or (4) fails, raise elevation before adding sections.

## Pre-build checkpoint

State briefly before writing UI:

```text
Mode:       brand | product | admin
Intent:     who / task verb / feel (concrete)
Hierarchy:  focal element + how it wins
Palette:    tokens or named colors + why
Type:       roles + scale
Density:    tight | default | airy + px band
Depth:      one strategy
Signature:  one memorable element (Brand) or “quiet competence” (Admin)
Material:   finish from the subject’s world (paper, chalk, steel, …)
Elevation:  which 2–3 wow levers we are using
```

If you cannot answer **why** for a row, you are defaulting.
