---
name: admin-ui
description: >
  Dense admin panels, dashboards, CRMs, settings, and data-heavy internal tools on
  vanilla CSS and server-rendered hypermedia. Hierarchy, density, app shells, tables,
  filters, metrics, and loading/empty/error states. Use when building or reviewing
  admin UI, back-office screens, or /admin-ui. Not for marketing or landing pages
  (use frontend-design).
---

# Admin UI (Vanilla / Hypermedia)

You help agents build **operator-first** interfaces: find, filter, act on records — without marketing aesthetics or AI card-grid slop.

**Stack authority:** [references/stack.md](references/stack.md)  
**Visual doctrine:** [references/visual-craft.md](references/visual-craft.md)  
**Patterns:** [references/admin-patterns.md](references/admin-patterns.md)  
**Motion numbers:** [references/motion-tokens.md](references/motion-tokens.md)

## Inspiration and attribution

Craft-first product/admin hierarchy, density, and intent discipline are **inspired by** public interface-design practice (e.g. Dammyjay93 `interface-design`) and operate-mode product thinking (Impeccable-style mode split). Production states and anti-generic UI floors draw from common frontend engineering guidance. This skill rewrites those ideas for vanilla CSS and hypermedia. Full credit: [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Initial response

When invoked with no specific question, reply only:

> Ready to craft dense admin and data UI with vanilla CSS and hypermedia. What tool or screen are we building?

Do not dump the whole skill until the user asks a concrete question.

## Scope

**Use for:** Dashboards, admin panels, CRMs, internal tools, settings pages, data tables, filterable indexes, bulk actions.

**Not for:** Landing pages, campaigns, brand marketing. Use `frontend-design` (Brand mode).

## Intent first

Before layout:

1. **Who** — the operator (role, context, frequency)
2. **Verb** — what they must accomplish on this screen
3. **Density** — tool-tight (default for tables) vs product-default vs airy (rare in admin)
4. **Feel** — concrete (“dense like a trading desk”, “calm ops console”) — not “modern”

If the prompt is only “make a dashboard,” narrow to the highest-leverage job (e.g. “triage failed payments”) before inventing KPI cards.

## Hierarchy for data

- **One focal task** per view (the table, the queue, the form — not three competing heroes)
- Labels demoted (small, muted, tracked); **values** lead (weight + size + `tabular-nums`)
- Status: text or icon **and** color — never color alone
- Squint test: structure readable, nothing harsh

Full hierarchy and anti-slop rules: [visual-craft.md](references/visual-craft.md).

## Shell and navigation

- Sidebar and canvas: **same surface** + subtle border (not a second colorful world)
- Nav width states relationship (~220–280px usually serves content)
- Page header: title + optional description + **one** primary action
- Skip link to `#main`

Recipes: [admin-patterns.md](references/admin-patterns.md).

## Core patterns (use the reference)

| Pattern | Key rule |
| --- | --- |
| Metric strip | Quiet strip; not three gradient icon cards |
| Filter bar | GET/URL (or form) state; shareable; clear action |
| Data table | Real `<table>`; sticky header; dense padding; aligned numbers |
| Pagination | Server links; show range |
| Settings | Sections + labels; hints; danger zone separate from save |
| Bulk / delete | Confirm irreversible; POST + host CSRF |
| Loading / empty / error | Skeleton geometry; empty invites next step; error offers retry |

Implement with semantic HTML and the smallest HTMX partial that keeps the shell stable.

## States are mandatory

| Region | Required |
| --- | --- |
| Controls | default, hover (fine pointer), active, focus-visible, disabled |
| Lists / tables | loading, empty, error, populated |
| Destructive | confirm path |

Missing states read as unfinished software.

## Motion

Admin chrome is high-frequency. Default to **no animation** on sort, filter, pagination, row select. Allow short feedback (button press scale, occasional toast, modal enter) per [motion-tokens.md](references/motion-tokens.md). Prefer motion skills only when a specific transition is in scope.

## Operator polish (wow as competence)

Spectacle belongs on Brand landings. Here, elevation is **speed, scan, trust**. After structure works, apply [admin-patterns.md](references/admin-patterns.md) § *Operator polish*:

| Polish | Example |
| --- | --- |
| Attention strip | “14 need a nudge” → applies at-risk filter |
| Row emphasis | Soft tint / left rule on at-risk rows + status text |
| Toolchrome | Command-style search, sticky headers, `/` hint optional |
| Action affordance | Row actions on hover/focus-within; always keyboard-reachable |
| Feedback | Quiet toast after nudge/export; dialog focus return |
| Empty | Domain SVG/CSS + one CTA — not a blank void |

**Anti-patterns:** hero gradients in the shell, staggered row entrances, confetti, glassmorphism KPI walls.

**Self-check:** Would a power user feel *faster* after your polish, or only see more chrome?

## Implementation posture

| Do | Do not |
| --- | --- |
| Server-rendered tables and forms | Client-only filter state as source of truth |
| Vanilla CSS tokens; extend host | Tailwind / React admin kits by default |
| Native `<dialog>` / `popover`, `<table>`, labeled inputs | Div grids as tables; unlabeled icon buttons |
| CSS `:has()` / GET forms for filter demos | A JS table framework for basic show/hide |
| Host partials; custom elements only when required | New SPA router for admin chrome |

**JS:** none by default. Filters, bulk-bar visibility, confirm, and mobile nav should use HTML/CSS (or server GET) first — [stack.md](references/stack.md) + [admin-patterns.md](references/admin-patterns.md) § *Zero-JS*.

If the host already uses another stack, match the host; still apply density, hierarchy, and state rules.

## Review format (required for UI reviews)

Single markdown table:

| Before | After | Why |
| --- | --- | --- |
| Dashboard of six equal gradient cards | Metric strip + primary queue table | Operator job was triage, not decoration |
| Div rows with no header cells | `<table>` + sticky `th` | Semantics, alignment, assistive tech |
| Filters only in JS memory | `method="get"` + query params | Shareable, back-button, no-JS path |

## Checklist

- [ ] Scope is admin/product-dense (not Brand)
- [ ] Operator + verb + density stated
- [ ] Focal task wins the layout
- [ ] Shell and primary action clear
- [ ] Tables real; numbers tabular
- [ ] Filters in URL/form
- [ ] Loading, empty, error present
- [ ] Destructive confirmed
- [ ] Operator polish applied where it speeds the job
- [ ] High-frequency chrome not animated
- [ ] Stack rules respected
