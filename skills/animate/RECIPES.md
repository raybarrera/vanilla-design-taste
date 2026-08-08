# Animation Recipes (Vanilla CSS / WAAPI)

Ready patterns for common cases. Adapt to host tokens.  
Craft defaults inspired by Emil Kowalski’s teaching; implementations are plain CSS/JS for hypermedia stacks. See [ATTRIBUTION.md](../../ATTRIBUTION.md).

Curves: `var(--ease-out)`, `var(--ease-in-out)`, `var(--ease-drawer)` from [motion-tokens.md](../../references/motion-tokens.md).

---

## Button press

```css
.button {
  transition: transform var(--duration-press, 160ms) var(--ease-out);
}

.button:active {
  transform: scale(var(--scale-press, 0.97));
}
```

Gate hover styles separately with `(hover: hover) and (pointer: fine)`.

---

## Popover / menu (origin-aware)

```css
.popover {
  transform-origin: top center; /* or top left / match placement class */
  transition:
    opacity var(--duration-popover, 200ms) var(--ease-out),
    transform var(--duration-popover, 200ms) var(--ease-out);
}

.popover.is-closed {
  opacity: 0;
  transform: scale(0.95);
  pointer-events: none;
}
```

Open by removing `is-closed` (or adding `is-open` with matching closed styles). Prefer transitions over mount keyframes.

---

## Tooltip

```css
.tooltip {
  transform-origin: bottom center;
  transition:
    transform var(--duration-tooltip, 150ms) var(--ease-out),
    opacity var(--duration-tooltip, 150ms) var(--ease-out);
}

.tooltip.is-closed {
  opacity: 0;
  transform: scale(0.97);
}

/* Once one tooltip is open, siblings may open with no delay/duration */
.tooltip.is-instant {
  transition-duration: 0ms;
}
```

Initial show delay belongs in a small enhancer or CSS if using `:hover` with care; skip delay for neighbors after the first open.

---

## Modal

```css
.modal {
  transform-origin: center;
  transition:
    opacity var(--duration-modal, 250ms) var(--ease-out),
    transform var(--duration-modal, 250ms) var(--ease-out);
}

.modal.is-closed {
  opacity: 0;
  transform: scale(0.96);
}

.modal-backdrop {
  transition: opacity var(--duration-modal, 250ms) var(--ease-out);
}

.modal-backdrop.is-closed {
  opacity: 0;
}
```

Prefer native `<dialog>` when the host allows; animate the dialog and backdrop together.

---

## Drawer / sheet

```css
.drawer {
  transform: translateY(0);
  transition: transform var(--duration-drawer, 400ms) var(--ease-drawer);
}

.drawer.is-closed {
  transform: translateY(100%);
}
```

Percentage translate tracks drawer height. Add drag only with a custom element (see **Drag to dismiss**).

---

## Toast (enter with @starting-style)

```css
.toast {
  opacity: 1;
  transform: translateY(0);
  transition:
    opacity 400ms ease,
    transform 400ms ease;
}

@starting-style {
  .toast {
    opacity: 0;
    transform: translateY(100%);
  }
}
```

Personality may use slightly slower `ease` than generic UI. Exit the same edge it entered.  
HTMX alternative: render toast partial with `is-closed`, settle, then remove `is-closed` on `htmx:afterSettle`.

---

## Accordion

```css
.accordion-panel {
  overflow: hidden;
  transition:
    height 200ms var(--ease-out),
    opacity 200ms var(--ease-out);
}
```

Measure target height in a tiny script or use `grid-template-rows: 0fr` / `1fr` patterns when acceptable. Keep duration short — height animation is not free.

```css
/* Modern grid collapse (no measured height) */
.accordion-panel {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 200ms var(--ease-out);
}

.accordion-panel.is-open {
  grid-template-rows: 1fr;
}

.accordion-panel > .accordion-panel-inner {
  overflow: hidden;
  min-height: 0;
}
```

---

## Stagger group entrance

Occasional lists only — not a list the user scrolls all day.

```css
.item {
  opacity: 0;
  transform: translateY(8px);
  animation: taste-fade-in 300ms var(--ease-out) forwards;
}

.item:nth-child(2) { animation-delay: 50ms; }
.item:nth-child(3) { animation-delay: 100ms; }
.item:nth-child(4) { animation-delay: 150ms; }

@keyframes taste-fade-in {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (prefers-reduced-motion: reduce) {
  .item {
    animation: none;
    opacity: 1;
    transform: none;
  }
}
```

Never block clicks while stagger plays.

---

## Hold to confirm

```css
.hold-overlay {
  clip-path: inset(0 100% 0 0);
  transition: clip-path 200ms var(--ease-out);
}

.hold-button:active .hold-overlay {
  clip-path: inset(0 0 0 0);
  transition: clip-path 2s linear;
}

.hold-button:active {
  transform: scale(var(--scale-press, 0.97));
}
```

`linear` is correct for progress fill.

---

## Scroll reveal (marketing only)

```css
.reveal {
  clip-path: inset(0 0 100% 0);
  transition: clip-path 600ms var(--ease-in-out);
}

.reveal.is-visible {
  clip-path: inset(0 0 0 0);
}
```

Toggle `is-visible` once via `IntersectionObserver`. Do not re-fire on every scroll-by. Skip on functional daily dashboards.

---

## Drag to dismiss (custom element sketch)

Use only when the host needs a gesture. No motion library.

```js
// Velocity dismiss: |distance| / elapsedMs > ~0.11 OR distance threshold
// On pointermove: el.style.transform = `translateY(${y}px)` on the element itself
// On release: WAAPI or CSS class to settle; hand off direction from velocity
// setPointerCapture on pointerdown; ignore extra touches while dragging
// Rubber-band past edges with progressive resistance
```

Prefer a single custom element that owns listeners and cleans up on disconnect.

---

## Programmatic without a library (WAAPI)

```js
element.animate(
  [
    { clipPath: "inset(0 0 100% 0)" },
    { clipPath: "inset(0 0 0 0)" },
  ],
  {
    duration: 1000,
    fill: "forwards",
    easing: "cubic-bezier(0.77, 0, 0.175, 1)",
  }
);
```

---

## Blur-masked crossfade

When two states flash during a swap:

```css
.content {
  transition:
    filter 200ms ease,
    opacity 200ms ease;
}

.content.is-transitioning {
  filter: blur(2px);
  opacity: 0.7;
}
```

Keep blur small (under ~20px). Prefer fixing structure first.
