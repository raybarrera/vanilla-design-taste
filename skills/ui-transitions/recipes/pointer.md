# Pointer and selection

Shared tokens: [../references/motion-tokens.md](../references/motion-tokens.md).  
Stack: [../references/stack.md](../references/stack.md).

Hover recipes **must** use `(hover: hover) and (pointer: fine)`. Touch gets the resting state.

---

## Avatar group hover

**Purpose:** feedback. **Frequency:** tens/day stacks (filters, assignee rows) → **skip** or 1–2px lift, no neighbor falloff, no bounce-out.

Delight / Brand: hovered item lifts slightly; neighbors may follow with a falloff. Hover-in: short `--ease-out`. Hover-out may be slightly softer — **not** a violent overshoot on product UI.

CSS-only first (sibling `~` is limited). Neighbor falloff needs a **tiny** pointer enhancer: write `--lift` on items, clean up on `mouseleave`. Set easing **before** the value write so in/out can differ. Track on the group, not on a transforming child.

```css
@media (hover: hover) and (pointer: fine) {
  .avatar-group:hover .avatar:hover {
    transform: translateY(-2px);
    transition: transform var(--duration-popover) var(--ease-out);
  }
}
```

If you add JS falloff, `requestAnimationFrame` only while moving; do not drive children from a parent variable updated every frame for large lists.

---

## Input clear

**Purpose:** feedback. **Frequency:** tens/day search → **instant** or a short opacity on the clear button, not a 1s dissolve.

Refuse per-frame word streaks, glow stacks, and duplicated mirror DOM. Native `<input>` + `type="search"` (or a clear `<button>`) is enough.

```html
<label>Search <input type="search" name="q"></label>
```

```css
.search-clear {
  transition: opacity var(--duration-press) ease;
}

.search:not([data-filled]) .search-clear {
  opacity: 0;
  pointer-events: none;
}
```

**JS:** only if the host has no `type="search"` clear and a button must empty the field. No `mix-blend-mode` theatre.

---

## Card tilt

**Purpose:** delight / Brand. **Frequency:** marketing tiles only. **Refuse** on admin tables, forms, and dense tools.

Outer wrapper stays flat (hit target). Inner card takes `rotateX` / `rotateY`. Bind `pointermove` on the **wrapper**, not the rotating card. Flatten under reduced motion. Cap follow duration (`--duration-popover` range); do not use a 1s return on product chrome.

```html
<div class="tilt">
  <article class="tilt-card">…</article>
</div>
```

```css
.tilt { perspective: 800px; }

.tilt-card {
  transform: rotateX(var(--tilt-rx, 0deg)) rotateY(var(--tilt-ry, 0deg));
  transition: transform var(--duration-modal) var(--ease-out);
}

@media (prefers-reduced-motion: reduce) {
  .tilt-card { transform: none !important; }
}
```

**JS:** justified for pointer tracking. `setPointerCapture` not required for hover-only. Ignore touch (`pointer: coarse`). Clean up listeners on disconnect.

---

## Tabs sliding

**Purpose:** spatial consistency. **Frequency:** occasional view switchers. Core nav used 100+/day: **no** pill slide — instant selected state.

**Prefer first:** radio group or links + server, selected style (background/weight) with a short color/`ease` transition. A sliding pill is optional polish.

If a pill is required: one decorative element; JS writes `transform` + `width` from the selected tab’s `offsetLeft` / `offsetWidth`. On first paint and resize, set those **without** a transition (suspend → reflow → restore) so the pill does not fly from `0`. Symmetric `--duration-popover`.

```html
<div class="seg" role="tablist">
  <span class="seg-pill" aria-hidden="true"></span>
  <button type="button" role="tab" aria-selected="true">Plan</button>
  <button type="button" role="tab" aria-selected="false">Debug</button>
</div>
```

```css
.seg {
  position: relative;
  display: inline-flex;
}

.seg-pill {
  position: absolute;
  inset: 0 auto 0 0;
  transition:
    transform var(--duration-popover) var(--ease-out),
    width var(--duration-popover) var(--ease-out);
}

.seg [role="tab"] {
  position: relative;
  z-index: 1;
}
```

Pill `width` is a justified layout tween (the highlight size *is* the point). Keep tabs usable with CSS/`aria-selected` if JS fails.
