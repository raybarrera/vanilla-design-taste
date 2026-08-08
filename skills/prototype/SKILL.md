---
name: prototype
description: >
  Build multiple genuinely different vanilla HTML/CSS variants of a UI piece
  behind a simple picker so a human can flip through them live and promote a
  winner. Explicit invocation only. Use when the user wants design exploration,
  multiple options, A/B UI directions, or /prototype.
disable-model-invocation: true
---

# Prototyping Variants (Vanilla)

Diverge on purpose: several shippable directions, one picker, no production edits until a human picks.

**Stack:** [references/stack.md](../../references/stack.md)  
**Picker chrome:** [PICKER.md](./PICKER.md)  
**Craft bar:** [references/motion-tokens.md](../../references/motion-tokens.md)

## Inspiration and attribution

Divergence workflow (named axes, isolated surface, promote-on-choice) is **inspired by** Emil Kowalski’s `prototype` skill in [emilkowalski/skills](https://github.com/emilkowalski/skills). This version builds **static HTML/CSS** (or host template partials) without React/Tailwind defaults. See [ATTRIBUTION.md](../../ATTRIBUTION.md).

## Operating posture

- Each variant is a direction you could defend shipping alone  
- Variants must **diverge on a named axis** (layout, density, personality, motion, interaction)  
- Sharing product tokens is good; three tints of the same idea is failure  
- Every variant meets the craft bar (easing, duration, reduced motion, no `scale(0)`)

## Hard rules

1. **Never edit production code** during exploration. Isolated surface only.  
2. State each variant’s axis in a phrase before building.  
3. Variants fully work — real interactions, realistic copy, no lorem-only dead ends.  
4. Picker chrome comes from [PICKER.md](./PICKER.md) — not a design contestant.  
5. After promotion, delete the prototype surface unless asked to keep it.  
6. **No Tailwind, React, or motion libraries** in the prototype unless the host production stack already is that (then match host, still isolate).

## Workflow

### Phase 1 — Scope

One component per run. Narrow “the dashboard” to the highest-leverage piece. Restate the brief in one sentence.

### Phase 2 — Recon

- Host stack and CSS tokens  
- Personality and where the piece will live  
- If no project: neutral grays, one accent, system font  

### Phase 3 — Directions

Default **3** variants (max 5). Name them by direction (“Quiet”, “Editorial”, “Playful”), never “Option A”.

Completion: every variant has a name + axis; no two share the same axis position.

### Phase 4 — Harness

| Context | Surface |
| --- | --- |
| App with routes | Isolated route e.g. `/prototypes/<slug>` or static dir the host already uses for experiments |
| No app | Single self-contained `prototype.html` (inline CSS/JS) |

- One variant visible at a time, full size, realistic surroundings  
- Switching is **instant** (no animation on the picker itself — high frequency)  
- Implement picker per [PICKER.md](./PICKER.md)

### Phase 5 — Hand off

Table for the human:

| # | Variant | Axis | When it wins | Cost |
| --- | --- | --- | --- | --- |

Stop. Choice is theirs.

### Phase 6 — Promote

Integrate the winner with host conventions. Delete prototype files. Optional: `keep <variant>, leave the picker`.

## Invocation variants

| Invocation | Behavior |
| --- | --- |
| `<description>` | Full flow, 3 variants |
| `<description> x5` | Up to 5 |
| `riff <variant>` | New set around that direction |
| `keep <variant>` | Promote + cleanup |

## Tone

Sell each direction honestly. Do not pre-declare a winner in the table. If two converged while building, cut one and say so.
