---
name: admin-ui
description: >
  Dense admin panels, dashboards, CRMs, debug/QA consoles, and data-heavy internal
  tools on vanilla CSS and server-rendered hypermedia. Multi-panel hierarchy,
  type size floors, field types, rows vs cards, alignment, shells, tables, filters.
  Use when building or reviewing admin UI, back-office screens, or /admin-ui. Not
  for marketing or landing pages (use frontend-design).
---

# Admin UI (Vanilla / Hypermedia)

You help agents build **operator-first** interfaces: find, filter, act on records — without marketing aesthetics, debug-dashboard slop, or microscopic type.

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

**Use for:** Dashboards, admin panels, CRMs, internal tools, **debug/QA consoles**, settings, data tables, filterable indexes, bulk actions.

**Not for:** Landing pages, campaigns, brand marketing. Use `frontend-design` (Brand mode).

## Intent first

1. **Who** — operator / debugger role and frequency  
2. **Verb** — single primary job (e.g. “load account → inspect diary”)  
3. **Density** — tool-tight **padding** OK; type must meet **size floors**  
4. **Primary work surface** — name it before drawing peer cards  
5. **Theme** — host tokens; **APCA** polarity for light/dark (not WCAG 2 ratios)

## Visual hierarchy (required)

Full detail: [admin-patterns.md](references/admin-patterns.md) § *Visual hierarchy*, *Multi-panel*, *Debug & internal tools*.

**Scan order:** task → one primary action → attention → filters → **work surface (most pixels)** → meta.

**Multi-panel:** name one **primary** surface. Secondary panes get quieter chrome. Meta counts are a **thin strip**, not five equal stat posters.

| Do | Do not |
| --- | --- |
| Diary/events table owns the viewport | “Debug dashboard” of equal cards + starved table |
| Quiet orientation metrics | Marketing-size KPI tiles on a QA tool |
| Demote labels; promote values | All strings same weight/size |
| Compact status chips | Chips larger than identity text |

## Type size floors (required)

Detail: [admin-patterns.md](references/admin-patterns.md) § *Type size floors*.

| Role | Minimum |
| --- | --- |
| Table / list **body** | **14px** preferred, **13px** floor |
| Form controls | **14px** |
| Labels, headers, meta, mono ids | **12px** floor |

**Never** ship ~11–12px table body so more columns fit. Prefer horizontal scroll, fewer columns, or disclosure. Dense padding ≠ microscopic type. Check **computed** px on a large display.

## Debug / loader consoles

Default flow: **Load identity → select entity → primary evidence table → secondary context**.

- Mono account/GUID field + **one** Load primary  
- Demote secondary header actions  
- Short lede (verb + constraint)  
- See anti-patterns: *debug dashboard*, *microtype density*, *every subsection is a product card*

## Rows vs cards

| Default | When |
| --- | --- |
| **Table** | Homogeneous records, compare, sort/filter/bulk |
| **Key-value** | Single record / settings |
| **Compact pane** | 0–3 related rows of context |
| **Cards** | Rare posters/galleries — not default inventory |

## Alignment & field types

- Numbers **end-align** + `tabular-nums`; fixed float precision  
- Names **start-align**; actions trailing  
- GUIDs: mono, muted, truncate + `title`  
- Timestamps: muted, tabular; ISO in `title` if needed  
- Long prose in cells: clamp / max-width  
- Empty: one `—` convention  
- Failure rows: tint ± **straight** stripe (no fingernail lip)  
- Selected list item: surface + weight (not a disabled pill)

## Shell and navigation

- Same surface sidebar + hairline border  
- Current nav via **background**, no fingernail rails on rounded chips  
- Page header: `h1` + optional short lede + **one** primary  

## Core patterns

| Pattern | Key rule |
| --- | --- |
| Metric strip | Orientation only; quiet; not a second hero |
| Filter bar | GET/URL state; one label alignment system |
| Data table | Real `<table>`; sticky header; **≥13–14px body** |
| Bulk / delete | Confirm irreversible |
| Loading / empty / error | Required on data regions |

## Motion

High-frequency chrome: little/no animation. Press + dialog only per [motion-tokens.md](references/motion-tokens.md).

## Operator polish

| Polish | Example |
| --- | --- |
| Attention strip | Count + control that applies filter |
| Row emphasis | Soft tint + square-end stripe |
| Selection | Background + weight |
| Feedback | Quiet toast; focus return |

**Anti-patterns:** debug dashboard, equal peer cards, microtype body, fingernail lips, accent spray, card-stat walls, confetti.

## Implementation posture

| Do | Do not |
| --- | --- |
| Host theme + APCA Lc | WCAG 2 ratio chasing; private palettes |
| Server tables/forms | Client-only filter source of truth |
| Readable rem/px floors | `0.72rem` table body on 16px root |

**JS:** none by default — [stack.md](references/stack.md).

## Review format (required)

| Before | After | Why |
| --- | --- | --- |
| Five equal stat posters over diary | Thin meta strip; diary largest | Work surface wins |
| Peer cards for users/topic/concept above table | Table primary; panes secondary | Multi-panel hierarchy |
| Table body ~11.5px | 14px (0.875rem) body | Legibility over packing |
| Fingernail lip on failure rows | Tint + straight `::before` stripe | Curved caps are slop |
| GUID as primary body text | Mono muted + `title` | Field type |
| Long topic full-width | Clamped cell | Column scan |

## Checklist

- [ ] Verb + primary work surface named  
- [ ] Multi-panel hierarchy (primary vs secondary vs meta)  
- [ ] Type size floors met (body ≥13–14px computed)  
- [ ] Metrics orientation-only  
- [ ] Field types + alignment correct  
- [ ] Host theme; APCA polarity if dual mode  
- [ ] No fingernail lips; straight stripes OK  
- [ ] Loader: one primary action  
- [ ] States, filters, stack rules  
