---
name: animate
description: >
  Build a UI animation from scratch on vanilla CSS and minimal JS — decide
  whether to animate, pick purpose, tool, properties, curve, and duration, then
  implement. Use when asked to animate something, add motion, make a control
  feel alive, or /animate. For review use review-animations; for audits use
  improve-animations.
---

# Building Animations (Vanilla)

Turn a motion request into an implementation that would pass a strict review — or correctly refuse to animate.

**Stack authority:** [references/stack.md](../../references/stack.md)  
**Tokens:** [references/motion-tokens.md](../../references/motion-tokens.md)  
**Recipes:** [RECIPES.md](./RECIPES.md)

## Inspiration and attribution

Build sequence, frequency gate, tool ladder idea, and “never ship” list are **inspired by** Emil Kowalski’s `animate` skill and public animation writing ([emilkowalski/skills](https://github.com/emilkowalski/skills), [animations.dev](https://animations.dev/)). Implementation targets CSS, WAAPI, and custom elements instead of Motion/React. See [ATTRIBUTION.md](../../ATTRIBUTION.md).

## Operating posture

Two failure modes — the first is worse:

1. **Animating something that should not move**
2. **Right moment, wrong ingredients** (ease-in entrance, `scale(0)`, keyframes on a toast, sluggish duration)

Do not present a menu of motion options. Make the call, one line of reason, write the code.

## Hard rules

1. Run the sequence in order. Steps 1–2 gate everything.
2. No approximated curves when pack or project tokens exist.
3. Extend host tokens; do not fork a parallel motion system.
4. Reduced motion and hover gating ship with the animation.
5. Cheapest tool that works — **never install a motion library for a fade**.
6. No React, Tailwind, or npm UI kits unless the human already chose that stack for the host app.

## Build sequence

### 1. Should this animate?

| Frequency | Decision |
| --- | --- |
| 100+/day (keyboard, command palette, core nav) | **Stop. No animation.** |
| Tens/day | Near-imperceptible or nothing |
| Occasional | Standard |
| Rare / first-time | Delight allowed |

Keyboard-initiated actions: always stop.

### 2. Purpose

Name one word-set from [motion-tokens.md](../../references/motion-tokens.md). Cannot name it → do not build.

### 3. Tool (vanilla ladder)

| Need | Tool |
| --- | --- |
| Hover, press, class/attribute toggle | **CSS transition** |
| Entry on insert, modern browsers OK | **`@starting-style`** |
| Predetermined motion under load | **CSS animation** |
| Programmatic control, no library | **WAAPI** |
| Gesture / drag / interruptible physics feel | **Custom element + pointer events + WAAPI** |
| Springs library, shared layout animation kit | **Human-approved dependency only** |

If the request is really “install a toast package,” refuse the package path and implement a small server-rendered or progressive toast with CSS instead — unless the host app already standardized on a library.

### 4. Properties

- Prefer **`transform` and `opacity`**
- Never enter from **`scale(0)`** — use ~`0.95` + opacity
- Popovers: **`transform-origin`** toward trigger; modals centered
- Prefer **percentage translates** (`translateY(100%)`) over magic pixels
- Set transform on the moving element, not via a parent variable updated every frame

### 5. Easing and duration

Use [motion-tokens.md](../../references/motion-tokens.md). UI usually **under 300ms**.

### 6. Interruption and exit

- Rapid triggers → **transitions**, not restarting keyframes
- Exit the way it entered (same edge / same origin story)
- Slow on deliberate hold; snappy on system response

### 7. Accessibility

Ship with:

```css
@media (prefers-reduced-motion: reduce) { /* opacity-only or shorter */ }

@media (hover: hover) and (pointer: fine) { /* hover motion only */ }
```

## Never ship

| Never | Instead |
| --- | --- |
| `transition: all` | Named properties |
| `scale(0)` entrance | `scale(0.95)` + opacity |
| `ease-in` on UI | `var(--ease-out)` |
| Animation on keyboard / 100+/day | Instant state change |
| UI duration > 300ms without reason | 150–250ms |
| Center origin on trigger-anchored popover | Origin toward trigger |
| Keyframes on rapid toasts/toggles | CSS transitions |
| Layout props for casual motion | `transform` / `opacity` |
| New motion npm dependency for simple UI | CSS or WAAPI |
| Ungated `:hover` motion | Fine-pointer media query |
| Missing reduced-motion consideration | Gentler variant |

## Output

Write the code (CSS first; JS only if required). Then a few lines max:

- Gate result (frequency + purpose); anything rejected and why
- Ingredients: tool, properties, curve, duration
- Feel-check note if needed (slow-mo in DevTools, real device for gestures)

## HTMX / server-rendered notes

- Prefer class toggles and partial swaps that leave elements in the DOM long enough for transitions
- For exit animations before remove, use a short “leaving” class + `transitionend`, or swap after animation via a tiny enhancer — keep it local
- Do not introduce a client router to get enter/exit hooks
