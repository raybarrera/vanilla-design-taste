---
name: admin-ui
description: >
  Dense admin panels, dashboards, CRMs, debug/QA consoles, and data-heavy internal
  tools on vanilla CSS and server-rendered hypermedia. Multi-panel hierarchy,
  type size floors, field types, rows vs cards, alignment, shells, tables, filters,
  domain finish, optical polish. Use when building or reviewing admin UI,
  back-office screens, or /admin-ui. Not for marketing or landing pages
  (use frontend-design).
---

# Admin UI (Vanilla / Hypermedia)

You help agents build **operator-first** interfaces that are **correct and beautiful**: find, filter, act on records — without marketing theater, debug-dashboard slop, or microscopic type. Correct structure that looks like generic gray admin still fails.

**Stack authority:** [references/stack.md](references/stack.md)  
**Visual doctrine:** [references/visual-craft.md](references/visual-craft.md)  
**Patterns:** [references/admin-patterns.md](references/admin-patterns.md)  
**Motion numbers:** [references/motion-tokens.md](references/motion-tokens.md)

## Inspiration and attribution

Craft-first product/admin hierarchy, density, and intent discipline are **inspired by** public interface-design practice (e.g. Dammyjay93 `interface-design`) and operate-mode product thinking (Impeccable-style mode split). Production states and anti-generic UI floors draw from common frontend engineering guidance. This skill rewrites those ideas for vanilla CSS and hypermedia. Full credit: [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Initial response

When invoked with no specific question, reply only:

> Ready to craft dense admin and data UI that is both correct and beautiful — vanilla CSS and hypermedia. What tool or screen are we building?

Do not dump the whole skill until the user asks a concrete question.

## Scope

**Use for:** Dashboards, admin panels, CRMs, internal tools, **debug/QA consoles**, settings, data tables, filterable indexes, bulk actions.

**Not for:** Landing pages, campaigns, brand marketing. Use `frontend-design` (Brand mode).

## Intent first

1. **Who** — operator / debugger role and frequency  
2. **Verb** — single primary job (e.g. “load account → inspect diary”)  
3. **Density** — tool-tight **padding** OK; type must meet **size floors**  
4. **Primary work surface** — name it before drawing peer cards  
5. **Feel** — concrete, domain-true (“warm paper classroom”, “cold steel yard”) — never only “clean admin”  
6. **Theme** — host tokens; **APCA** polarity for light/dark (not WCAG 2 ratios)

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
- **Form controls:** native text/number/select/checkbox/radio/date — **styled** with host field tokens (shared height, inset fill, focus). No naked browser chrome in filters/settings ([visual-craft.md](references/visual-craft.md) § *Native form controls*; [admin-patterns.md](references/admin-patterns.md) § *Form controls*)

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

## Elevation (required)

Tidy anti-slop admin can still feel **forgettable**. Raise elevation with 2–3 Product/Admin levers from [visual-craft.md](references/visual-craft.md) § *Wow without slop*. Recipes: [admin-patterns.md](references/admin-patterns.md) § *Operator polish*.

| Required | Admin form (not Brand) |
| --- | --- |
| **Signature** | One competence move an operator would name besides “a table” (command filter, attention strip, data/mono codes, or the finish). Fail: “gray SaaS admin.” |
| **Material finish** | Encode the subject’s world in **chrome** — paper, steel, enamel via hue, hairlines, inset wells, radius. Not grain overlays, ink bands, or display-serif theses. |
| **Optical polish** | Nested radii, hairline ink, tabular nums, press + focus, uneven group rhythm. |
| **Copy** | Operator verbs; realistic records; empty/error give a next step. |

Spend boldness in **one** place. Hierarchy and type floors still win. “No marketing” is not “no beauty.”

**Anti-flat:** would an operator recognize this as *this* tool vs generic admin?

## Operator polish

| Polish | Example |
| --- | --- |
| Attention strip | Count + control that applies filter |
| Row emphasis | Soft tint + square-end stripe |
| Selection | Background + weight |
| Feedback | Quiet toast; focus return |
| Domain finish | Warm paper classroom vs night steel yard — tokens, not a second palette |

**Anti-patterns:** debug dashboard, equal peer cards, microtype body, fingernail lips, accent spray, card-stat walls, confetti, generic gray-correct chrome.

## Implementation posture

| Do | Do not |
| --- | --- |
| Host theme + APCA Lc | WCAG 2 ratio chasing; private palettes |
| Server tables/forms | Client-only filter source of truth |
| Readable rem/px floors | `0.72rem` table body on 16px root |
| Tokenized native fields | Unstyled system inputs/selects next to designed buttons |

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
| Naked browser select in filter bar | Tokenized `.select` + chevron | Native + styled |
| Neutral gray chrome, no subject link | Domain finish in tokens (paper / steel) | Flat-but-correct fails |
| One gap everywhere; no press/hairlines | Optical polish + uneven group rhythm | Unseen details compound |

## Checklist

- [ ] Verb + primary work surface named  
- [ ] Feel + named domain finish (not only “clean admin”)  
- [ ] Elevation: 2–3 Product/Admin levers; anti-flat check passed  
- [ ] Optical polish (nested radii, hairlines, press, focus, uneven rhythm)  
- [ ] Multi-panel hierarchy (primary vs secondary vs meta)  
- [ ] Type size floors met (body ≥13–14px computed)  
- [ ] Metrics orientation-only  
- [ ] Field types + alignment correct  
- [ ] Native form controls styled to host tokens (filters, settings, loaders)  
- [ ] Host theme; APCA polarity if dual mode  
- [ ] No fingernail lips; straight stripes OK  
- [ ] Loader: one primary action  
- [ ] Copy: operator language; empty/error give a next step  
- [ ] States, filters, stack rules  
