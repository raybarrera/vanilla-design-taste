---
name: admin-ui
description: >
  Dense admin panels, dashboards, CRMs, settings, and data-heavy internal tools on
  vanilla CSS and server-rendered hypermedia. Hierarchy, density, rows vs cards,
  alignment, field-type presentation, app shells, tables, filters, and states. Use
  when building or reviewing admin UI, back-office screens, or /admin-ui. Not for
  marketing or landing pages (use frontend-design).
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
5. **Theme** — host tokens only; light/dark via **APCA** (polarity-aware), not WCAG 2 ratios

If the prompt is only “make a dashboard,” narrow to the highest-leverage job (e.g. “triage failed payments”) before inventing KPI cards.

## Visual hierarchy (required)

Full tables: [admin-patterns.md](references/admin-patterns.md) § *Visual hierarchy*.

**Scan order:** task title → one primary action → attention (if any) → filters → **work surface** (most pixels) → meta.

**Within a record/row:** identity → status → measure (tabular) → meta → trailing actions.

| Do | Do not |
| --- | --- |
| Demote labels; promote values | Everything the same weight |
| One `h1`; quieter breadcrumbs | Three title sizes competing |
| Compact status + clear name | Huge status pills, tiny identity |
| Quiet metric strip above the queue | Six equal marketing KPI cards |

## Rows vs cards

Decide the container before styling. Full table: [admin-patterns.md](references/admin-patterns.md) § *Rows vs cards*.

| Default | When |
| --- | --- |
| **Table rows** | Homogeneous records, compare columns, sort/filter/bulk |
| **Key-value** | Single record detail / settings |
| **Cards** | Few objects with multi-line “poster” content (rare in admin) |
| **Metric strip** | Summary above a table — not instead of one |

Indexes and queues: **table first**. Card grids of stats are almost always wrong.

## Alignment

Numbers **end-align** + `tabular-nums`. Names **start-align**. Actions in one trailing column. Filters share one label pattern. See [visual-craft.md](references/visual-craft.md) § Alignment and admin-patterns § Alignment.

## Field types

Present data by kind — [admin-patterns.md](references/admin-patterns.md) § *Field types*:

- Labels muted; titles/names stronger  
- Ints/floats/money/% → tabular, consistent decimals, end-align in columns  
- GUIDs → mono, muted, truncate with full value in `title`  
- Status → text + color (never color alone)  
- Empty → “—” or “Not set”, one convention  

## Shell and navigation

- Sidebar and canvas: **same surface** + subtle border (not a second colorful world)
- Nav width ~220–280px; current item via **background**, not inset box-shadow lip
- Page header: title + optional description + **one** primary action
- Skip link to `#main`

## Core patterns

| Pattern | Key rule |
| --- | --- |
| Metric strip | Quiet strip; not three gradient icon cards |
| Filter bar | GET/URL (or form) state; shareable; clear action |
| Data table | Real `<table>`; sticky header; dense padding; aligned numbers |
| Pagination | Server links; show range |
| Settings | Sections + labels; hints; danger zone separate from save |
| Bulk / delete | Confirm irreversible; POST + host CSRF |
| Loading / empty / error | Skeleton geometry; empty invites next step; error offers retry |

## States are mandatory

| Region | Required |
| --- | --- |
| Controls | default, hover (fine pointer), active, focus-visible, disabled |
| Lists / tables | loading, empty, error, populated |
| Destructive | confirm path |

## Motion

Admin chrome is high-frequency. Default to **no animation** on sort, filter, pagination, row select. Allow short feedback (button press scale, occasional toast, modal enter) per [motion-tokens.md](references/motion-tokens.md).

## Operator polish

| Polish | Example |
| --- | --- |
| Attention strip | “14 need a nudge” → applies filter |
| Row emphasis | Soft tint + optional full-height border-inline-start — **never** inset lip shadow |
| Toolchrome | Command-style search, sticky headers |
| Actions | focus-within / hover reveal; keyboard always |
| Feedback | Quiet toast; dialog focus return |

**Anti-patterns:** hero gradients, card-stat walls, inset `box-shadow` lips, parallel palettes, confetti.

## Implementation posture

| Do | Do not |
| --- | --- |
| Host theme tokens; both modes if they exist | Invent a private admin palette |
| Server-rendered tables and forms | Client-only filter state as source of truth |
| Native dialog/popover, real tables | Div grids as tables; unlabeled icon buttons |
| CSS `:has()` / GET forms for demos | JS table frameworks for basic show/hide |

**JS:** none by default — [stack.md](references/stack.md).

## Review format (required)

| Before | After | Why |
| --- | --- | --- |
| Six equal gradient KPI cards | Metric strip + primary queue table | Work surface must win |
| `box-shadow: inset 2px 0 0` on nav | Background on current item | Inset lips are agent slop |
| GUID as body-primary text | Mono muted truncated + `title` | Type-appropriate presentation |
| Money left-aligned, mixed decimals | End-align, tabular, fixed fractions | Compare and scan |

## Checklist

- [ ] Operator + verb + density stated
- [ ] Host theme; light/dark APCA polarity check if both modes
- [ ] Hierarchy: work surface wins; labels vs values clear
- [ ] Rows vs cards (or key-value) justified
- [ ] Alignment rules held
- [ ] Field types correct (tabular, mono GUID, etc.)
- [ ] No inset lip shadows
- [ ] Table/filters/states/destructive paths complete
- [ ] High-frequency chrome not animated
- [ ] Stack rules respected
