# Visual Craft

Shared visual design doctrine for this pack. Stack law still lives in [stack.md](./stack.md). Motion numbers live in [motion-tokens.md](./motion-tokens.md).

**Attribution:** Anti-slop patterns and distinctive-direction discipline draw from public frontend design skills (notably Anthropic `frontend-design` and production-floor guidance in community UI engineering skills). Brand-vs-product mode separation draws from the Impeccable-style operate/persuade split. Product hierarchy and density craft draw from craft-first interface design practice (e.g. Dammyjay93 `interface-design`). See [ATTRIBUTION.md](./ATTRIBUTION.md) (pack root or skill `references/`). All of the below is rewritten for **vanilla CSS + server-rendered HTML**.

## Prefer project systems first

If the host app already defines surfaces, type ramps, spacing, and radii — **use those**. Extend tokens; do not invent a parallel palette beside a working system.

## Theme consistency (non-negotiable on host projects)

When editing UI **inside an existing app**, the project’s established theme wins.

| Do | Do not |
| --- | --- |
| Reuse host semantic tokens (`--surface-*`, `--content-*`, `--accent`, spacing, radius) | Invent a second palette “because this screen is special” |
| Map new roles onto existing names (extend, don’t fork) | Drop random hex next to tokenized components |
| Match depth strategy already in use (borders vs shadow) | Switch to glassmorphism or hard shadows mid-product |
| Match type ramp and weight roles | Introduce a display face only used once in admin chrome |
| If both light and dark exist, implement **both** with the same token roles | Hard-code light-only grays that break dark mode |

**Greenfield / pack samples** may define a self-contained theme, but still: one hue family, semantic roles, and no one-off hex spray.

**Litmus:** Diff the CSS variables — new screens should mostly *consume* tokens, not declare a private mini-system.

## Light / dark legibility check (APCA, polarity-aware)

This pack does **not** use WCAG 2 contrast ratios as the design bar. WCAG 2 overstates contrast for dark pairs, under-predicts some light pairs, and often forces muddy “compliant” combos that still read poorly — especially in dark mode.

Use **APCA** (Accessible Perceptual Contrast Algorithm): polarity-aware lightness contrast reported as **Lc** (positive = dark text on light background; negative = light text on dark). Absolute value is what you compare to targets.

**Tool:** [apcacontrast.com](https://apcacontrast.com/) — enter **text/icon color** and **background** in the correct slots (polarity matters; swap is not free). See also [Myndex APCA docs](https://git.myndex.com/).

### Polarity rules

1. Always measure **foreground on its actual background** (not “these two hexes abstractly”).  
2. Light-on-dark is **not** the same as dark-on-light at the same WCAG ratio — APCA’s sign and magnitude capture that.  
3. When a control has multiple layers (button label on accent on page), check the **painted pair the eye reads** (label vs button fill).  
4. Alpha text: blend against the real background first, then measure.  
5. Verify **each mode** the product ships (light and dark tokens), not only the one you designed in.

### Bronze Lc targets (pack default)

Simplified from APCA Bronze guidance (size/weight matter; when unsure, go higher Lc or larger/heavier type):

| Use | Target | Notes |
| --- | --- | --- |
| Body / fluent columns | **\|Lc\| ≥ 75** preferred; **90** for small body | e.g. ≥14px/400 or ≥18px/300 for Lc 90 body-ish use |
| Readable UI content (not dense body columns) | **\|Lc\| ≥ 60** | Primary labels, nav text, table primary cells |
| Large headlines / big metrics | **\|Lc\| ≥ 45** | Heavier/larger type; don’t crank contrast until it glares |
| Spot-readable / secondary | **\|Lc\| ≥ 30** | Meta, timestamps; avoid for primary content |
| Placeholder / disabled copy | **\|Lc\| ≥ 30** absolute floor for any text you still expect to read | Below ~15 treat as decorative/invisible |
| Non-text chrome (borders, dividers that must be seen) | **\|Lc\| ≥ 15** vs adjacent surface | Fine details/icons need more (often ≥30–45) |
| Primary button label | **\|Lc\| ≥ 60** on the button fill | Prefer 75 when type is small |

These are **readability targets**, not a mandate to desaturate the brand into gray sludge. Prefer adjusting **weight/size** or **surface steps** before killing hue.

### Do not

- Use WCAG 2 **4.5:1 / 3:1** as the pass bar in this pack (or axe/Lighthouse contrast as gospel)  
- Force near-black text on near-black “dark mode” because a ratio tool said pass  
- Assume the same muted gray hex works on light and dark surfaces  
- Check only resting state — include hover, focus, selected, error, disabled  

### Mode-specific traps

| Mode | Common failure | Fix |
| --- | --- | --- |
| Light | Washed secondary text; invisible hairlines | Raise \|Lc\| for secondary; slightly stronger border token |
| Dark | WCAG-pass pairs that still look milky or crush | Measure with APCA; often need different lightness steps than light mode |
| Dark | Shadows as only elevation | Surface step + hairline (shadows vanish) |
| Both | One hard-coded gray for “muted” | Separate semantic tokens per polarity |
| Both | Status color-only | Text/icon + color; check Lc of the **label**, not only the swatch |

### How to verify

1. Toggle host theme (or `.theme-dark` / `prefers-color-scheme`)  
2. For each critical pair, run [apcacontrast.com](https://apcacontrast.com/) with correct polarity  
3. Spot-check primary text, muted text, links, button labels, status text, focus ring against its background  
4. Squint test still applies — structure without harsh noise  

If the product has only one mode, say so; still meet APCA targets in that polarity.

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
| **Fingernail lip** — a short side rail whose ends **curve or cap** with the box radius (looks like a rounded fingernail on the corner) | Agent chrome slop; draws the eye to the corner, not the row | Soft **background** change, and/or a **straight** full-height stripe (no curved caps) |
| Random parallel palette beside host tokens | Theme drift | Extend host semantic tokens only |
| **Naked browser form chrome** next to designed UI | System widgets break cohesion | Style native controls with host tokens (see § Native form controls) |

**Fingernail lip (explicit ban — the look, not one property):**  
The slop is the **visual**: a partial vertical accent on a rounded box that ends in a **curved, capped “fingernail”** at the top and/or bottom corner. That happens with *any* technique that paints a thick edge **following the border-radius**:

- `box-shadow: inset 2px 0 0 var(--text-primary)` (classic)
- `border-inline-start: 3px solid …` on an element with `border-radius`
- `outline` / gradient “edge” hacks that round off with the corner
- Using `--content-primary` / text color as the rail so it reads as a hard ink lip

**Straight stripes are fine.** A full-height, **rectangular** indicator (square ends, no radius on the stripe itself) is a clean status cue. Prefer a `::before` bar, or a left border only on **unrounded** table rows.

```css
/* Good: selection via surface only */
.nav-link[aria-current="page"] {
  background: var(--surface-inset);
  color: var(--content-primary);
  /* no side rail on rounded nav chips */
}

/* Good: straight stripe (square ends) — not a fingernail */
.row--risk {
  position: relative;
  background: color-mix(in srgb, var(--warning) 8%, var(--surface-raised));
}
.row--risk::before {
  content: "";
  position: absolute;
  inset-block: 0;
  inset-inline-start: 0;
  width: 3px;
  background: var(--warning);
  border-radius: 0; /* square ends — required */
}

/* Bad: edge follows rounded corner → fingernail */
.card-selected {
  border-radius: 8px;
  border-inline-start: 3px solid var(--content-primary); /* slop */
  box-shadow: inset 3px 0 0 var(--content-primary); /* same slop */
}
```

**Litmus:** Zoom the top-leading corner of the selected control. If you see a **rounded cap** of accent color, rewrite it. If you see a clean vertical rule or only a background shift, you’re fine.

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

## Alignment

Alignment is hierarchy’s quieter twin. Misalignment is the fastest “unfinished” tell after missing states.

### Rules

1. **Pick a column system and hold it.** Page content, tables, and form labels share edges — not “almost aligned.”  
2. **Same start edge for labels** in a form column (`grid-template-columns: max-content 1fr` or fixed label column).  
3. **Numbers right-align** in columns that are compared (money, counts, %). Labels and names stay start-aligned.  
4. **Action columns** share one end edge (usually trailing). Do not scatter Open / Edit at random x-positions.  
5. **Vertical rhythm:** row heights consistent within a table; form fields share control height (e.g. 36px).  
6. **Optical, not only mathematical:** icons next to text often need 1–2px nudge; large display type may need tracking, not more margin.  
7. **Don’t mix centering strategies** on one toolbar (some items `margin: auto`, some absolute) without a grid.  
8. **RTL-safe edges:** prefer `inline-start` / `inline-end` (and logical borders) over hard `left` / `right` when the product supports RTL.

### Admin quick map

| Surface | Align |
| --- | --- |
| Page title block | Start; actions end on same row baseline |
| Filter bar | Controls baseline-align; labels above or inline consistently — not mixed |
| Data table | Sticky header cells match body column alignment |
| Metric strip | Values baseline or top-aligned as a set — not mixed per card |
| Modal / popover | Title, body, actions share one content width |

### Anti-patterns

- Cascading indent with no grid (“this field is 12px further in because why not”)  
- Columns that look aligned at 1440px and collapse into a jagged stack at 768px with no plan  
- Icon buttons of different hit-box widths making the action column wobble  

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
- **Inputs:** slightly inset (often a touch darker than surroundings), not raised like buttons. Full control system: § *Native form controls* below.
- **Borders:** low-opacity edges that disappear until you look for structure; solid harsh hex lines are a last resort.
- Nested radii: `outer ≈ inner + padding` (concentric), not the same radius on parent and child.

## Native form controls (style them)

**Native markup ≠ unstyled chrome.** Prefer real `<input>`, `<select>`, `<textarea>`, checkbox, radio, etc. — then **style them with the same tokens as the rest of the product**. Shipping a polished layout with default OS/browser widgets is a craft failure: the eye reads “unfinished,” not “semantic.”

### Doctrine

| Do | Do not |
| --- | --- |
| Keep native elements (a11y, keyboard, forms, progressive enhancement) | Re-implement selects/checkboxes in JS only for looks |
| One shared control system (classes or element rules) from host tokens | One-off hex/radius per field |
| Match type, radius, border, focus, and height to buttons/chrome | Mix designed buttons with naked system inputs |
| Style **every** control type the screen uses | Style text inputs, leave `<select>` / checkbox as browser default |
| Use host control CSS when it already exists | Invent a parallel field kit beside a working system |

**Litmus:** screenshot the form next to a primary button. If controls look like a different product (or like Windows/macOS defaults), restyle before shipping.

### What must match the aesthetic

Apply the product’s surface, type, radius, and border strategy to:

| Control | Notes |
| --- | --- |
| Text-like | `text`, `search`, `email`, `password`, `url`, `tel`, `number` — same base field class |
| Multiline | `textarea` — same border/fill/type; min-height for 2–3 lines |
| Select | Native `<select>` — same field chrome + custom chevron (`appearance` reset); keep real `<option>`s |
| Checkbox / radio | Native input — `accent-color` minimum; for full cohesion, restyle with `appearance: none` + tokenized box **on the real input** (not a fake div) |
| Date / time / file | Style the **field shell** like text inputs; accept some OS picker UI inside the dialog |
| Range | Track/thumb from tokens if used |

### Shared field system (required properties)

Host tokens first. Greenfield / samples should define one base rule set, e.g. `.input` / `.select` / `.textarea` or a grouped selector:

```css
/* Pattern — names follow the host; tokens are required */
.input,
.select,
.textarea {
  font: inherit;
  font-size: 0.875rem; /* 14px floor — match body */
  line-height: 1.4;
  color: var(--content-primary);
  background: var(--surface-inset);
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-sm);
  min-height: 2.25rem; /* share with buttons in the same row */
  padding: 0.5rem 0.75rem;
  width: 100%;
  max-width: 100%;
}

.input:hover,
.select:hover,
.textarea:hover {
  border-color: var(--border-strong);
}

.input:focus-visible,
.select:focus-visible,
.textarea:focus-visible {
  outline: 2px solid var(--focus-ring);
  outline-offset: 2px;
  border-color: var(--focus-ring);
}

.input:disabled,
.select:disabled,
.textarea:disabled {
  opacity: 0.55;
  cursor: not-allowed;
}

.input[aria-invalid="true"],
.input:user-invalid {
  border-color: var(--danger);
}

.select {
  appearance: none;
  background-image: /* token-colored chevron SVG or mask */;
  background-repeat: no-repeat;
  background-position: right 0.65rem center;
  padding-inline-end: 2rem;
}

input[type="checkbox"],
input[type="radio"] {
  accent-color: var(--accent); /* floor */
  width: 1.05rem;
  height: 1.05rem;
  /* Prefer full restyle with appearance: none when accent alone still looks foreign */
}
```

| Rule | Practice |
| --- | --- |
| **Height** | Text, select, and adjacent buttons share one control height (e.g. 36px / `2.25rem`) |
| **Type** | Form control text ≥ **14px**, same family as body (mono only for GUID/code fields) |
| **Fill** | Inset surface — not raised like primary buttons |
| **Focus** | Same `--focus-ring` language as the rest of the app |
| **Invalid** | Border + message text; not color alone |
| **Number** | Same shell as text; `tabular-nums` when values are compared; don’t leave default spinners clashing if the rest is custom (hide or restyle consistently) |
| **Dual theme** | `color-scheme: light` / `dark` on `html` or form roots so native pickers/scrollbars track polarity; still paint field chrome with tokens |
| **Density** | Tool-tight padding OK; do not shrink type below floors |

### Checkbox and radio (keep native)

1. Real `<input type="checkbox|radio">` + associated `<label>` (wrapping or `for`/`id`).  
2. Minimum: `accent-color: var(--accent)` and size that hits the hit-target floor (expand label hit area).  
3. When system widgets still clash: `appearance: none`, draw box/dot with borders/background from tokens, style `:checked` / `:indeterminate` / `:focus-visible` / `:disabled` on the **input** — not a separate non-focusable decoration.  
4. Segmented filters may hide the input visually (`visually-hidden` / clipped) **only** when the visible label is clearly selected/unselected and keyboard focus is visible on the label or input.

### Anti-patterns

| Smell | Fix |
| --- | --- |
| Unstyled gray system text field in a tokenized admin | Apply shared `.input` (or host equivalent) |
| Designed primary button beside default blue checkbox | Tokenize checkbox/radio |
| Custom dropdown div soup “for branding” | Style native `<select>` first |
| Placeholder as the only label | Visible `<label>` + optional hint |
| Different radius/border on every field | One control radius + border token |
| File/date left raw while text is styled | At least match the field shell |

Admin field layout and type-by-kind presentation: [admin-patterns.md](./admin-patterns.md) § *Field types* / *Form controls*.

## Typography

- **Brand:** display face with restraint + readable body; type treatment can be part of the signature.
- **Product / Admin:** system UI stack or host font is fine; hierarchy from weight/size/color matters more than novelty.
- Headings: slightly tighter tracking as size grows; body line-height ~1.4–1.6.
- Dynamic numbers (tables, KPIs, timers): `font-variant-numeric: tabular-nums`.
- `text-wrap: balance` on short headings when supported; avoid orphan-heavy marketing lines.

### Type size floors (product / admin)

Do not “win” density by shrinking type until tables are ~11–12px on a large screen.

| Role | Floor (CSS px) |
| --- | --- |
| Product / admin body and table primary cells | **14px** preferred, **13px** minimum |
| Labels, column headers, meta, mono ids in tables | **12px** minimum |
| Form control text | **14px** (match body) |

- Prefer tighter **padding** and fewer columns over sub-floor type.  
- Don’t shrink `html` font-size below 16px (or host root) just to pack admin.  
- Verify **computed** px in devtools. Full admin tables: [admin-patterns.md](./admin-patterns.md) § *Type size floors*.

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
- Contrast: **APCA Lc**, polarity-aware — [apcacontrast.com](https://apcacontrast.com/). Do **not** optimize for WCAG 2 ratios. Run the **light / dark legibility check** above.

## Accessibility floor

- Real controls: `<button>`, `<a href>`, labeled inputs — not `<div onclick>`
- Keyboard: every action reachable; visible `:focus-visible`
- Prefer native `<dialog>`, `<details>`, form validation where they fit — **and style those controls** (§ *Native form controls*)
- Do not rely on color alone for state
- Hit targets: aim 44×44px; if the glyph is smaller, expand the hit area
- Honor `prefers-reduced-motion` (see motion-tokens)
- Gate hover-only motion with `(hover: hover) and (pointer: fine)`

## States (not optional)

Every interactive control: default, hover (fine pointer), active, focus-visible, disabled.  
Form fields also need **invalid** (and checked/indeterminate for checkbox/radio).  
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
- Native control → style with host tokens → host partial → (only if needed) small custom element — never invent a client SPA for chrome or for form-widget cosplay
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
Palette:    host tokens first; named colors only if greenfield
Type:       roles + scale
Density:    tight | default | airy + px band
Depth:      one strategy
Alignment:  edges / number columns / action column
Controls:   shared native field system from tokens (not browser defaults)
Signature:  one memorable element (Brand) or “quiet competence” (Admin)
Material:   finish from the subject’s world (paper, chalk, steel, …)
Elevation:  which 2–3 wow levers we are using
Modes:      light / dark checked with APCA (or single-mode stated)
```

If you cannot answer **why** for a row, you are defaulting.
