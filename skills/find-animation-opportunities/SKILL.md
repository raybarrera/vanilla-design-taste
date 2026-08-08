---
name: find-animation-opportunities
description: >
  Search UI for places that would benefit from motion — and reject places that
  should stay still. Read-only; proposes exact vanilla CSS/WAAPI recipes, does
  not implement. Use when asked what could be animated, make this feel more
  alive, or /find-animation-opportunities.
---

# Finding Animation Opportunities

Find high-conviction motion opportunities. **Reject most candidates.**

**Tokens:** [references/motion-tokens.md](../../references/motion-tokens.md)  
**Stack:** [references/stack.md](../../references/stack.md)

## Inspiration and attribution

Restraint-first opportunity hunting is **inspired by** Emil Kowalski’s essay [You Don't Need Animations](https://emilkowal.ski/ui/you-dont-need-animations) and the `find-animation-opportunities` skill in [emilkowalski/skills](https://github.com/emilkowalski/skills). Recipes here are vanilla CSS / WAAPI. See [ATTRIBUTION.md](../../ATTRIBUTION.md).

## Hard rules

1. Do not modify source code. Report only.  
2. Every suggestion must pass the full Gate.  
3. Cap output: **at most 5–7** suggestions for a whole app; fewer for one view.  
4. Suggest only tools allowed by [stack.md](../../references/stack.md).

## The Gate (all four)

### 1. Frequency

| Frequency | Verdict |
| --- | --- |
| 100+/day | Reject |
| Tens/day | Reject or near-imperceptible only |
| Occasional | Eligible |
| Rare / first-time | Eligible (delight) |

Keyboard-initiated: always reject.

### 2. Purpose

Must be one of: feedback, spatial consistency, state indication, prevent jarring change, explanation, delight (rare only).

### 3. Speed

Must fit duration budgets in motion-tokens. If it only works as a slow showpiece on daily UI, reject.

### 4. Function

Do not decorate information-dense reading/acting surfaces for style alone.

## Where to hunt

**Feedback gaps**

- Pressables with no `:active` scale  
- Destructive clicks that need hold-to-confirm  

**Teleporting state**

- Instant appear/disappear on occasional UI  
- Accordions that snap  
- List add/remove without bridge (if not high-frequency)  

**Missing spatial story**

- Menus with no origin link to trigger  
- Sheets/toasts that exit a different path than they entered  

**Group entrances**

- Occasional grids that pop all at once → short stagger  

**Gesture seams**

- Drags that hard-stop with no damping (only if product needs gestures)  

**Delight budget**

- First-run, empty success, celebration only  

Useful greps: `transition`, `@keyframes`, `is-open`, `hx-`, `:active`, `dialog`, empty-state components.

## Workflow

1. Recon stack, tokens, personality, frequency map  
2. Sweep hunt list  
3. Gate ruthlessly  
4. Report  

## Required output

### Part 1 — Opportunities

| # | Location | Today | Purpose | Frequency | Suggested motion |
| --- | --- | --- | --- | --- | --- |

Suggested motion cells need exact properties, curves, durations (host tokens preferred). CSS/WAAPI only unless host already has something else.

### Part 2 — Rejected candidates (required)

At least 2–5 deliberate rejects with the gate reason. This is what proves restraint.

### Part 3 — Verdict

How much motion this surface needs; single highest-leverage suggestion; handoff to `improve-animations` or `animate` if the user wants implementation next.

If nothing survives the gate, say so — that is success.
