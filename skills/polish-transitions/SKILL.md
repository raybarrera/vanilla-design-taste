---
name: polish-transitions
description: >
  Tune existing UI motion to this pack's motion tokens — duration, easing,
  scale, travel, and open/close timing — without adding new transitions.
  Use when motion already exists but feels slow, snappy, inconsistent, or
  off-token, or when asked to polish/refine/tokenize transitions, or
  /polish-transitions. Match on usage, not nearest numbers. For installing a
  catalog recipe use ui-transitions; for pass/fail review use review-animations.
---

# Polish Transitions (Vanilla)

Align motion that **already ships** to [motion-tokens.md](references/motion-tokens.md). Do not add new choreography here.

**Stack:** [references/stack.md](references/stack.md)  
**Tokens:** [references/motion-tokens.md](references/motion-tokens.md)

Companion to [`ui-transitions`](../ui-transitions/SKILL.md) (install a recipe) and `review-animations` (pass/fail, including “should this animate at all”).

## Inspiration and attribution

Usage-first token matching, open/close asymmetry, hover in vs out, and stagger/delay rules are **inspired by** the polish skill in [Jakubantalik/transitions.dev](https://github.com/Jakubantalik/transitions.dev). This skill **does not** vendor that token scale (`--duration-quick`, `--ease-smooth-out`, …), Tailwind/Motion adapters, or the Refine panel. Numbers and curves come from this pack. See [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Core doctrine: match on usage, never nearest number

A value is not wrong because it is 20ms off. It is wrong when it does not fit **what the motion does**. Infer usage first (modal close, dropdown open, tooltip, toast in, …), then pick the pack token or duration band whose usage matches.

A 300ms modal close still maps to a **shorter close** (~150–200ms) because both are “modal close,” even though the numbers differ.

If usage matches **no** pack band, leave it. Never force a swap because a number is close.

If the motion fails the **frequency gate** or has no purpose, recommend **delete** (or hand off to `review-animations`) — do not tokenize lag.

## What to scan

Prefer the host’s CSS:

- `.css` files, `<style>` blocks in templates/HTML
- Custom properties on `:root` / host tokens
- `transition` / `animation` shorthands and longhands, `@keyframes`
- Hardcoded `ms` / `s`, `cubic-bezier`, `ease-in`, `translate*`, `scale(`, `blur(`

Do **not** treat Tailwind arbitrary values, CSS-in-JS, or Motion variants as the default hunt. If the host already uses those, still apply craft (usage, frequency, reduced motion) and **do not churn the stack** to vanilla in the name of this pack.

Skip nodes that already use host `--duration-*` / `--ease-*` correctly.

## The dimensions (this pack)

Use host names when they exist. Otherwise the suggested custom properties in [motion-tokens.md](references/motion-tokens.md).

| Dimension | Pack source | Notes |
| --- | --- | --- |
| Duration | Duration budgets + open/close table | UI usually under 300ms; sheets may be longer |
| Easing | Easing table | No `ease-in` on UI response; `--ease-out` default |
| Scale | `--scale-enter`, `--scale-press` | Never pre-scale below ~0.9 for chrome |
| Travel | Physical defaults | Prefer `%` translates for sheets; tiny px for in-place swaps |
| Blur | Optional swap mask | ≤ ~2–3px; omit on plain fades; drop under reduced motion |

Do **not** introduce `--duration-stagger` / `--blur-small` families unless the host already has them. Stagger is 30–80ms per item as a practice, not a required new token.

## Polish rules

Restate of [motion-tokens.md](references/motion-tokens.md) — that file wins if they drift.

### Open / close

Closes are faster and quieter. No bounce on close. Symmetric (same both ways): page slide, tabs pill, accordion, icon swap, in-place text swap.

### Hover in vs out

- **In:** short, `--ease-out`, `--duration-popover` or less.
- **Out:** may be slightly softer; product/admin should **not** use violent overshoot. Gate with fine pointer.

### Stagger and delay

- 30–80ms per item; **total** stagger (offset × count) under ~300ms.
- Intent delay (~80ms) for tooltips only — filter accidents, not pad slowness.
- If motion feels late, shorten **duration** before adding delay.
- **Never delay a close or hover-out.**

## Commands

### Audit (default, read-only)

**Triggers:** `/polish-transitions`, “polish my transitions”, “timing feels off”, “tokenize durations”, “align motion tokens”.

1. Scan as above.
2. Infer usage; map to pack tokens/bands; apply polish rules.
3. Output **only rows that should change**, one markdown table:

| File:line | Usage | Before | After | Why |
| --- | --- | --- | --- | --- |

Include `no matching token usage` as a short footnote list, not fake swaps.

4. Call out frequency-gate deletes separately.
5. Do not edit. End with: confirm to apply, or point at `ui-transitions` if they need a full recipe instead.

### Apply

**Triggers:** “apply the polish”, “write the token changes”, confirmation after audit.

1. If this session has no audit table, run the audit first (scope to a named file if given).
2. Replace hardcoded motion with `var(--…)` when the host already defines those names; otherwise write the **literal** from [motion-tokens.md](references/motion-tokens.md) and offer to add the `:root` block **once**.
3. Touch only motion values. No restyle, no recipe swap, no new dependencies.
4. Keep units the file already uses (`250ms` vs `0.25s`) unless switching to `var(--…)`.

## Relationship to other skills

| Need | Skill |
| --- | --- |
| Should this animate? Fail `ease-in`, `scale(0)`, `transition: all` | `review-animations` |
| Whole-app audit + implementation plans (no edits) | `improve-animations` |
| Install a named pattern (modal, toast, …) | `ui-transitions` |
| From-scratch motion, no catalog match | `animate` |
| Off-token but justified motion | **this skill** |

## Never

- Map everything to a 27-entry foreign `_root.css`
- Scan the whole monorepo’s `node_modules`
- “Fix” high-frequency motion by making it on-token
- Add springs/libraries to polish a fade
