---
name: ui-transitions
description: >
  Apply a known UI transition on vanilla CSS and server-rendered HTML — dropdowns,
  dialogs, toasts, tabs, accordions, badges, swaps, and similar chrome. Use when
  asked to add a transition, animate a modal/menu/toast/tabs/toggle, or
  /ui-transitions. Run the frequency gate first; refuse high-frequency motion.
  For from-scratch motion use animate; for review use review-animations; for
  token tuning of existing motion use polish-transitions.
---

# UI Transitions (Vanilla)

Pick **one** catalog recipe and implement it with host tokens, native HTML, and the cheapest tool on the stack ladder.

**Stack authority:** [references/stack.md](references/stack.md)  
**Tokens:** [references/motion-tokens.md](references/motion-tokens.md)

Recipes:

- [recipes/surfaces.md](recipes/surfaces.md) — resize, dropdown, dialog, panel, page, accordion, toast, tooltip, morph
- [recipes/feedback.md](recipes/feedback.md) — badge, shake, success, like, checkbox, toggle, learn-more
- [recipes/content.md](recipes/content.md) — number, text swap, icon swap, skeleton, shimmer, stagger, spinning counter
- [recipes/pointer.md](recipes/pointer.md) — avatar row, input clear, card tilt, sliding tabs

## Inspiration and attribution

The *jobs* in this catalog (what a dropdown vs a modal vs a toast is for) are **inspired by** the public collection at [transitions.dev](https://transitions.dev) / [Jakubantalik/transitions.dev](https://github.com/Jakubantalik/transitions.dev). This skill **rewrites** those jobs for this pack: pack motion tokens, native HTML first, no `t-*` drop-in namespace, no npm CLI, no Refine panel, no React/Motion/Tailwind defaults. See [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Operating posture

Two failure modes — the first is worse:

1. **Animating something that should not move**
2. **Right job, wrong stack** (JS widget, layout animation, parallel token file, `scale(0)`)

Do not present a menu of 27 options. Match the visible element, name the recipe, one line of reason, write the code — or refuse.

If nothing in the catalog fits, hand off to `animate` (build sequence) instead of inventing a 28th pattern.

## Hard rules

1. Run the gate in order. Frequency and purpose first.
2. Use **host** `--ease-*` / `--duration-*` when they exist. Else extend [motion-tokens.md](references/motion-tokens.md). **Do not** add a second motion scale (`--duration-quick`, `--ease-smooth-out`, per-snippet `--pN-*`, or a giant `_root.css` of 27 families).
3. Walk the stack ladder in [stack.md](references/stack.md). Native HTML → CSS → hypermedia → tiny JS.
4. Prefer **`transform` and `opacity`**. Layout (`width`/`height`) only when the size change *is* the point, and prefer `grid-template-rows: 0fr / 1fr` over measured height.
5. Never enter from **`scale(0)`**. Use `var(--scale-enter)` (~0.95) + opacity.
6. Reduced motion is **gentler**, not always `transition: none`. Hover motion only under `(hover: hover) and (pointer: fine)`.
7. Adapt **host class names**. Do not force a `t-*` namespace onto an existing component.
8. No React, Tailwind, Motion, or npm UI kits unless the host already chose that stack.

## Build sequence

### 1. Should this animate?

Use the frequency table in [motion-tokens.md](references/motion-tokens.md). Keyboard and 100+/day: **stop**.

### 2. Purpose

Name one: feedback, spatial consistency, state indication, prevent jarring change, explanation, delight (rare only). Cannot name it → do not build.

### 3. Match one recipe

Match the **visible UI element**, then the verb. See **Decision rules** below. Tie-breaker: lower overhead (dropdown before modal, native checkbox before custom draw, number pop-in before spinning reels).

### 4. Tool

Cheapest tool that the recipe allows. If the recipe lists a native control, use that control **styled to the product**.

### 5. Timing

Open/close asymmetry, intent delay, and duration bands live in [motion-tokens.md](references/motion-tokens.md). UI usually under 300ms.

## Decision rules

| You see | Recipe | File |
| --- | --- | --- |
| Trigger + surface that **grows from it** | Menu dropdown | surfaces |
| Centered overlay the user must deal with | Modal (`<dialog>`) | surfaces |
| Surface that **slides into a region** (not a full overlay) | Panel reveal | surfaces |
| Two screens: list ↔ detail, step 1 ↔ 2 | Page side-by-side | surfaces |
| Header + collapsible body | Accordion (`<details>`) | surfaces |
| Transient message that leaves on its own | Toast | surfaces |
| Hover/focus hint over a control | Tooltip | surfaces |
| Circular trigger that **becomes** the panel | Plus → menu morph | surfaces |
| Element changes width/height as the point | Card resize | surfaces |
| Small dot on a trigger | Notification badge | feedback |
| Invalid field / “try again” | Error shake | feedback |
| Completed action, persistent check | Success check | feedback |
| Heart/star/bookmark celebration | Like button | feedback |
| Boolean box that fills | Checkbox (`<input type="checkbox">`) | feedback |
| Binary thumb on a track | Toggle (styled checkbox) | feedback |
| Inline link whose arrow leans forward | Learn more hover | feedback |
| Number updates in place | Number pop-in | content |
| Label text changes in the same slot | Text states swap | content |
| Two icons in one slot | Icon swap | content |
| Placeholder then real content | Skeleton reveal | content |
| “Thinking…” label that should feel alive | Shimmer text | content |
| Headline + line entering with rhythm | Texts reveal | content |
| Number that should feel like an **event** | Spinning counter (rare only) | content |
| Horizontal stack that lifts on hover | Avatar group hover | pointer |
| Clearing a text field | Input clear | pointer |
| Card that tilts toward the pointer | Card tilt (Brand only) | pointer |
| Small mutually exclusive options | Tabs (radios/links first) | pointer |

**No clear match** → `animate`, not a guess.

If two fit, pick the lighter one unless the design is clearly the heavier surface.

## Commands

| Phrase | Behaviour |
| --- | --- |
| `/ui-transitions`, “add a transition”, “animate the modal/menu/…” | Gate → match one recipe → implement |
| “list transitions”, “what’s in the catalog” | Print the decision table. No project edits. |
| “apply the right transition here” | Same as implement, scoped to the open file / pointed element. Propose one line, then write. |

Do **not** use the upstream verbs `transitions reveal/apply/refine` — those belong to the original pack and collide with `review-animations` / `polish-transitions`.

## Output

Write the code (CSS first; JS only if the recipe’s native path failed). Then a few lines max:

- Gate result (frequency + purpose); anything refused and why
- Recipe name + tool (e.g. `<dialog>` + CSS transition)
- Ingredients: properties, host tokens, open/close timings
- Script justification if JS shipped (*what native path failed*)

## HTMX / server-rendered notes

- Prefer class or attribute toggles the server already owns (`aria-expanded`, `[open]`, `popover`)
- Leave the node in the DOM long enough for a **transition** to run; do not restart keyframes on every swap
- Exit: a short leaving class + `transitionend`, or swap after animation via a tiny enhancer
- Do not invent a client router to get enter/exit hooks

## Never ship

| Never | Instead |
| --- | --- |
| Drop-in `t-*` stylesheet + `_root.css` from another pack | Host classes + this pack’s tokens |
| `scale(0)` or icon-swap from `scale(0.25)` | `var(--scale-enter)` + opacity |
| Parallel `--duration-quick` / `--ease-smooth-out` scale | `--duration-popover`, `--ease-out`, … |
| Custom checkbox/toggle/dialog in JS for looks | Native control, styled |
| 1s per-frame clear-dissolve or 1400ms digit reels on daily UI | Instant or short opacity |
| Hover tilt / avatar bounce on admin chrome | Skip, or near-imperceptible |
| `transition: all` | Named properties |
| `transition: none !important` as the only reduced-motion story | Opacity/color, drop travel |
| Ungated `:hover` motion | Fine-pointer media query |
