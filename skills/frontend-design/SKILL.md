---
name: frontend-design
description: >
  Distinctive, intentional visual design for vanilla CSS and server-rendered HTML —
  product and marketing surfaces. Anti-slop defaults, typography, hierarchy, tokens,
  copy, and brand-vs-product modes. Use when building or reshaping UI look, avoiding
  AI-template aesthetics, choosing type/layout/palette, or /frontend-design. Not for
  React/npm UI libraries; dense admin tables and dashboards → admin-ui.
---

# Frontend Design (Vanilla / Hypermedia)

You help agents ship interfaces that look **designed for this brief**, not like median AI UI — on an HTML-first stack.

**Stack authority:** [references/stack.md](references/stack.md)  
**Visual doctrine:** [references/visual-craft.md](references/visual-craft.md)  
**Motion numbers:** [references/motion-tokens.md](references/motion-tokens.md)

## Inspiration and attribution

Distinctive-direction and anti-template discipline is **inspired by** widely used public skills (notably Anthropic `frontend-design` and production UI guidance such as Addy Osmani’s frontend UI engineering notes). Brand vs product mode separation draws from the Impeccable-style persuade/operate split. This skill rewrites those ideas for vanilla CSS and server-rendered hypermedia. Full credit: [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Initial response

When invoked with no specific question, reply only:

> Ready to shape distinctive frontend UI with vanilla CSS and hypermedia — product or marketing. What surface are we designing?

Do not dump the whole skill until the user asks a concrete question.

## When not to use this skill

| Situation | Prefer |
| --- | --- |
| Admin dashboards, CRMs, dense data tables, internal tools | `admin-ui` |
| Build or review a specific animation | `animate` / `review-animations` / other motion skills |
| Small press/feel polish only | `design-taste` |
| Exploring multiple visual directions | `prototype` |

## Mode first (required)

Name **Brand** or **Product** before designing. Rules differ — see [visual-craft.md](references/visual-craft.md).

| Mode | Examples | Expression | Density |
| --- | --- | --- | --- |
| **Brand** | Landing, marketing, campaigns, portfolio | Higher: signature type, bold layout, one memorable moment | Often airier |
| **Product** | App chrome, settings, everyday SaaS screens | Lower: scanability and consistency | Default product spacing |

Admin-dense tools are Product taken further — hand off to `admin-ui`.

## Intent brief

Before code, pin:

1. **Subject** — what this is (concrete, not “a SaaS”)
2. **Audience** — who is looking
3. **Job** — the page’s single primary job
4. **Feel** — concrete words (“cold like a terminal”, “warm like a notebook”) — never only “clean and modern”

If the brief is too vague, ask one short question **or** state a responsible assumption and proceed.

Ground choices in the subject’s world (materials, vernacular, artifacts). That is where distinctive palettes and type come from.

## Plan before code

Work in two passes (thinking may stay private; show the plan when confidence is high or the change is costly).

1. **Compact design plan**
   - **Color:** 4–6 named values or host tokens
   - **Type:** display (Brand) + body + optional data/utility face
   - **Layout:** one-sentence concept (+ ASCII wireframe if helpful)
   - **Signature:** one element the page will be remembered by (Brand); Product may choose “quiet system” as the signature
2. **Self-critique vs defaults** — revise anything that matches the anti-slop list in [visual-craft.md](references/visual-craft.md)
3. **Build** only from the revised plan; derive color/type from tokens, not one-off hex in every rule

Spend boldness in **one** place. Cut decoration that does not serve the brief.

## Elevation bar (avoid flat-but-correct)

Tidy anti-slop layouts can still feel **forgettable**. Raise elevation with 2–3 levers from [visual-craft.md](references/visual-craft.md) § *Wow without slop* — not by stacking more sections.

**Required for Brand work:**

1. **Signature** — one memorable material/layout/type move from the subject’s world  
2. **Material finish** — encode paper, chalk, metal, film, etc. in CSS (grain, rules, bands), not only hex  
3. **Type drama** — real display scale jump; one italic or weight accent phrase max  
4. **Optical polish** — nested radii, hairlines, balance/pretty wrap, press + focus  
5. **Motion budget** — hero entrance + optional once-only scroll reveal; hover lift on CTAs; `prefers-reduced-motion`  

**Signature test:** a stranger describes the page in five seconds without the logo. If they say “generic SaaS,” redesign the signature before adding content.

**Anti-flat check:** screenshot without logo still recognizable? Where was boldness spent (one place)?

## Craft rules (summary)

Details live in [visual-craft.md](references/visual-craft.md). Non-negotiables:

- One focal point per view; weight and color hierarchy beat size mush
- Product/admin body and table cells meet **type size floors** (≥13–14px body; see visual-craft) — not ~11px “compact”
- Spacing on a 4/8px scale; uneven rhythm between groups; **alignment** held (see visual-craft § Alignment)
- One depth strategy (borders / subtle shadow / surface steps)
- **Theme consistency:** host semantic tokens; no parallel palette
- **Light/dark legibility** checked for every mode the product supports
- No **fingernail lips** (curved side rails on rounded boxes — any property); straight stripes OK
- States: default, hover (fine pointer), active, focus-visible, disabled; data regions need loading/empty/error
- Accessibility floor: real controls, keyboard, focus-visible; **APCA Lc** contrast (not WCAG 2 ratios); no color-only status

### Brand-specific

- Hero is a **thesis**, not a stock gradient card grid
- Typography can carry personality; pair faces deliberately (load distinctive display if needed; avoid Inter/Space Grotesk as the personality)
- Structural devices (numbers, eyebrows, rules) only when they encode real structure
- Asymmetry and section ink bands over equal card grids
- Product preview frames: one depth treatment (perspective or soft stack), caption that links to real UI when available
- Motion: occasional explanatory or delight — still name a purpose ([motion-tokens.md](references/motion-tokens.md))

### Product-specific

- Consistency and speed over spectacle
- System or host fonts are fine; hierarchy still required
- Prefer quiet surfaces; accent is scarce and meaningful
- High-frequency chrome: little or no motion
- “Wow” = competence (feedback, states, density) — see `admin-ui` for dense tools

## Copy

Words are design material:

- User language, not system jargon
- Active voice; same action name through the flow (“Publish” → “Published”)
- Empty and error states give **direction**, not mood
- Realistic content while designing — never lorem-only layouts

## Implementation posture

| Do | Do not |
| --- | --- |
| Semantic HTML + server templates | SPA frameworks by default |
| Vanilla CSS + custom properties | Tailwind / CSS-in-JS by default |
| Native controls, `popover`, `:has()`, CSS motion | JS for toggles, reveals, or filters HTML/CSS can do |
| Smallest HTMX partial for state | Client store for page chrome |
| Match host tokens and conventions | Parallel design system beside an existing one |

**JS:** none by default. See [stack.md](references/stack.md) affordances ladder. Decorative scroll reveal must not require script.

If the host already uses a different stack, match the host; still apply craft rules.

## Review format (required for UI reviews)

Single markdown table:

| Before | After | Why |
| --- | --- | --- |
| Purple gradient hero, no subject link | Domain-derived palette + one signature image | Defaults read as AI-generic |
| Flat type: everything 16px regular | Label muted/sm; value semibold; clear h1 | Hierarchy needs weight and role |
| `transition: all 300ms` on cards | Named props + motion-token durations | Avoid `all`; stay under UI budgets |

One table, one row per issue.

## Checklist

- [ ] Mode named (Brand / Product)
- [ ] Intent brief answered
- [ ] Plan critiqued against anti-slop list (including no fingernail lips)
- [ ] Signature + material finish named (Brand)
- [ ] Elevation levers chosen (2–3); anti-flat check passed
- [ ] Focal point, hierarchy, and alignment clear
- [ ] Type size floors met where product/admin UI is in scope
- [ ] Host theme tokens; light/dark APCA polarity check
- [ ] Spacing scale and one depth strategy
- [ ] Realistic copy; empty/error considered
- [ ] A11y floor met (keyboard/semantics + APCA, not WCAG 2 ratios)
- [ ] Motion purposeful, budgeted, reduced-motion safe
- [ ] Stack ladder respected
