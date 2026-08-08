---
name: review-animations
description: >
  Strict review of animation and motion against vanilla design-taste standards.
  Default to flagging; approval is earned. Use when reviewing motion in a diff,
  PR, or UI surface, or when the user runs /review-animations. Does not implement
  features or review non-motion code.
disable-model-invocation: true
---

# Reviewing Animations

Review motion only. Decline general code review and point to a general review skill.

**Standards:** [STANDARDS.md](./STANDARDS.md)  
**Stack:** [references/stack.md](../../references/stack.md)  
**Tokens:** [references/motion-tokens.md](../../references/motion-tokens.md)

## Inspiration and attribution

Review posture, non-negotiable standards, and Before/After/Why tables are **inspired by** Emil Kowalski’s `review-animations` skill in [emilkowalski/skills](https://github.com/emilkowalski/skills). Rules are re-expressed for CSS/WAAPI/hypermedia stacks. See [ATTRIBUTION.md](../../ATTRIBUTION.md).

## Operating posture

Bias toward **motion that feels right**. A transition that “works” but is sluggish, high-frequency, wrong-origin, or layout-thrashing is a fail. Default to flagging.

## Ten non-negotiables

1. **Justified motion** — named purpose; “looks cool” on frequent UI fails  
2. **Frequency-appropriate** — keyboard / 100+/day → no animation  
3. **Responsive easing** — enter/exit ease-out or strong custom; `ease-in` on UI fails  
4. **Sub-300ms UI** unless justified (sheets may be longer)  
5. **Origin and physicality** — no `scale(0)`; popovers from trigger; modals centered  
6. **Interruptibility** — rapid UI uses transitions, not restarting keyframes  
7. **GPU-friendly properties** — prefer `transform` / `opacity`  
8. **Accessibility** — reduced motion + hover gating  
9. **Asymmetric deliberate/response timing** where relevant  
10. **Cohesion** — motion matches product personality; delete when unsure  

Also flag **stack regressions**: new Tailwind/React/Motion deps introduced only to animate something CSS can do.

## Escalation triggers

- `transition: all`
- `scale(0)` entrances
- `ease-in` on UI
- Motion on keyboard / high-frequency actions
- UI duration > 300ms without reason
- Wrong `transform-origin` on trigger-anchored UI
- Keyframes on rapid toasts/toggles
- Animating layout props casually
- Parent CSS variable thrashing for child transforms
- Missing reduced-motion on movement
- Ungated hover motion
- Surprise motion library install

## Remedial hierarchy

1. Delete  
2. Reduce  
3. Fix easing  
4. Fix origin / physicality  
5. Make interruptible  
6. Move to GPU-friendly props  
7. Asymmetric timing  
8. Polish (stagger, blur mask, `@starting-style`)  
9. A11y and cohesion  

Prefer CSS fixes over new dependencies.

## Required output

### Part 1 — Findings table

| Before | After | Why |
| --- | --- | --- |
| … | … | … |

One row per issue. Cite `file:line`. Pull exact curves/durations from STANDARDS.md or host tokens.

### Part 2 — Verdict

Tier commentary (omit empty tiers):

1. Feel-breaking regressions  
2. Missed simplifications (delete/reduce)  
3. Performance  
4. Interruptibility and timing  
5. Origin, physicality, cohesion  
6. Accessibility  
7. Stack violations (illegal deps / framework churn)

Close with **Block** or **Approve** and why.
