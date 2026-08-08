---
name: fluid-interfaces
description: >
  Fluid, physical UI motion for the web without a spring library by default —
  direct manipulation, interruptibility, momentum, rubber-banding, sheets, and
  reduced motion. Use for gesture-driven UI, drawers, drag/swipe, velocity
  handoff, or /fluid-interfaces. Prefer CSS and WAAPI; no Motion/Framer unless
  the host already depends on it.
---

# Fluid Interfaces (Vanilla Web)

Make interactive surfaces feel continuous and physical using **pointer events, CSS, and WAAPI**.

**Stack:** [references/stack.md](references/stack.md)  
**Tokens:** [references/motion-tokens.md](references/motion-tokens.md)

## Inspiration and attribution

Fluid-interface principles (response on press, 1:1 tracking, interruptibility, momentum projection, rubber-banding, materials) draw on:

- Apple WWDC design talks, especially *Designing Fluid Interfaces* (2018)  
- Emil Kowalski’s distillation of those ideas for the web in [emilkowalski/skills](https://github.com/emilkowalski/skills) (`apple-design`) and his animation writing  

This skill **re-implements the web advice** with CSS/WAAPI/custom elements instead of Motion/Framer. See [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Core idea

A surface feels alive when motion:

1. Starts from the **current on-screen value**  
2. Responds **immediately** to input  
3. Can be **grabbed and reversed** mid-flight  
4. Carries **velocity** from gesture into settle  
5. **Resists** at edges instead of hard-stopping  

## 1. Response

- Feedback on **pointer down**, not only click  
- Continuous feedback during drag (1:1), not only on release  
- Audit artificial delays on the input path  

```css
.button:active {
  transform: scale(0.97);
  transition: transform 100ms var(--ease-out);
}
```

## 2. Direct manipulation

- Prefer **Pointer Events** + `setPointerCapture`  
- Respect **grab offset** (do not jump the element under the finger to its center)  
- Keep a short history of positions/timestamps for velocity  

## 3. Interruptibility

- Never lock input for the whole transition if the user can reverse  
- On redirect, read the **live** transform/opacity and continue from there  
- CSS transitions retarget well for non-gesture UI; for gestures, WAAPI or frame loops that sample current value  
- Avoid one-shot keyframes for interactive dismiss  

## 4. Behavior over choreography

Fixed-duration choreography cannot respond to new input mid-way. For gestures:

- Update transform from pointer while down  
- On release, animate to a target with WAAPI, optionally easing with a custom curve  
- True spring integrators are optional advanced JS — only add if the host needs them; do not pull Motion by default  

Critically damped (no bounce) is the default settle. Add bounce only when the gesture had real momentum.

## 5. Velocity handoff

On release, compute velocity from recent pointer samples. Use it to:

- Decide commit vs cancel (flick threshold, e.g. distance/time ≳ 0.11 in px/ms-scale units — tune per control)  
- Choose snap target via **projection** (see below)  
- Seed the settle animation so there is no seam between drag and animation  

## 6. Momentum projection

Do not snap only to nearest point at the release position. Project where the gesture was going, then snap to the nearest valid target to that projection. Exponential-decay style projection is common for sheets and carousels (as discussed in industry samples of Apple’s fluid interfaces work).

## 7. Spatial consistency

- Enter and exit along the **same path**  
- Anchor menus/sheets to their trigger when they are not full-screen modals  
- Mirror easing on reversible transitions when using cubic-beziers  

## 8. Rubber-banding

Past an edge, apply progressive resistance. Hard clamps feel broken; soft resistance feels physical.

## 9. Gesture checklist

| Gesture | Notes |
| --- | --- |
| Tap | Highlight on down; commit on up; allow cancel by dragging away |
| Drag | Small hysteresis before axis lock; then 1:1 |
| Competing gestures | Detect in parallel, cancel losers once intent is clear |
| Multi-touch | Ignore additional fingers mid-drag |

## 10. Frame smoothness

- Prefer `transform` and `opacity`  
- `requestAnimationFrame` only while actively tracking; stop on release after settle  
- Avoid layout reads/writes thrash in the move handler (batch reads then writes)

## 11. Materials (CSS)

Approximate depth with:

```css
.chrome {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(20px) saturate(180%);
}
```

Respect `prefers-reduced-transparency` by raising opacity and dropping blur. Do not stack light glass on light glass.

## 12. Reduced motion

```css
@media (prefers-reduced-motion: reduce) {
  .sheet {
    transition: opacity 200ms ease;
    transform: none !important;
  }
}
```

Replace large travels with short crossfades. Drop elastic overshoot.

## 13. Implementation shape in this pack

Prefer a **custom element** that:

- Sets up pointer listeners in `connectedCallback`  
- Cleans up in `disconnectedCallback`  
- Writes `element.style.transform` on the moving node  
- Settles with WAAPI or a class-based CSS transition  
- Works as progressive enhancement on server-rendered markup  

```html
<drag-sheet class="sheet">
  <div class="sheet-panel">…</div>
</drag-sheet>
```

## 14. Design foundations (short)

Purpose, agency, responsibility, familiarity, flexibility, simplicity (not bare minimalism), craft, delight. Motion is not confetti on top of a weak flow.

## When to stop

If the control is high-frequency or keyboard-first, **do not** add fluid gesture chrome. Instant state change is correct.

## Output

When implementing: keep JS local, document the gesture math briefly in the PR not in inline comments if the host forbids narrating comments, and verify on a real touch device.
