# Surfaces

Shared tokens: [../references/motion-tokens.md](../references/motion-tokens.md).  
Stack wins over any snippet: [../references/stack.md](../references/stack.md).

Every recipe: named properties; `transform`/`opacity` unless noted; reduced-motion gentler variant; close faster than open unless the table says symmetric.

---

## Card resize

**Purpose:** prevent jarring change. **Frequency:** occasional. **Not** for rows the user expands all day.

Prefer `grid-template-rows: 0fr / 1fr` (or `0fr / 1fr` columns) over tweening `width`/`height`. Tween layout sizes only when the size change is the visual point and grid cannot express it.

```html
<article class="card" data-size="compact">…</article>
```

```css
.card {
  transition:
    transform var(--duration-modal) var(--ease-out),
    opacity var(--duration-modal) var(--ease-out);
}

.card[data-size="compact"] .card-extra {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows var(--duration-modal) var(--ease-out);
}

.card[data-size="expanded"] .card-extra {
  grid-template-rows: 1fr;
}

.card-extra-inner {
  overflow: hidden;
  min-height: 0;
}
```

Do not put padding on the `0fr` track — pad the inner node so the panel can close fully.

**JS:** none if a class/attribute toggle already exists (checkbox, `<details>`, server swap).

---

## Menu dropdown

**Purpose:** spatial consistency. **Frequency:** occasional.

Prefer native `popover` / `popovertarget` (or a server-toggled open class). Origin toward the trigger.

```html
<button popovertarget="filters-menu" type="button">Filters</button>
<div id="filters-menu" popover class="menu" data-origin="top-center">…</div>
```

```css
.menu {
  transform-origin: top center;
  opacity: 0;
  transform: scale(var(--scale-enter));
  transition:
    opacity var(--duration-popover) var(--ease-out),
    transform var(--duration-popover) var(--ease-out);
}

.menu:popover-open,
.menu.is-open {
  opacity: 1;
  transform: scale(1);
}

.menu.is-closing {
  opacity: 0;
  transform: scale(0.99);
  transition-duration: 150ms;
}

.menu[data-origin="top-left"] { transform-origin: top left; }
.menu[data-origin="top-right"] { transform-origin: top right; }
.menu[data-origin="bottom-center"] { transform-origin: bottom center; }

@media (prefers-reduced-motion: reduce) {
  .menu {
    transform: none;
    transition: opacity 150ms ease;
  }
}
```

**JS:** only if you must animate out before removing from the tree — swap `is-open` → `is-closing`, clear `is-closing` on `transitionend` (or a timeout read from the computed duration). Do not leave `is-closing` stuck or the next open starts from the closing scale.

---

## Modal

**Purpose:** spatial consistency + state. **Frequency:** occasional.

Use native `<dialog>`. Center origin. Open `--duration-modal`; close shorter.

```html
<dialog class="modal" id="confirm">
  <form method="dialog">…</form>
</dialog>
```

```css
.modal {
  transform-origin: center;
  opacity: 0;
  transform: scale(var(--scale-enter));
  transition:
    opacity var(--duration-modal) var(--ease-out),
    transform var(--duration-modal) var(--ease-out),
    overlay var(--duration-modal) var(--ease-out) allow-discrete,
    display var(--duration-modal) var(--ease-out) allow-discrete;
}

.modal[open] {
  opacity: 1;
  transform: scale(1);
}

.modal:not([open]) {
  transition-duration: 150ms;
}

@starting-style {
  .modal[open] {
    opacity: 0;
    transform: scale(var(--scale-enter));
  }
}

@media (prefers-reduced-motion: reduce) {
  .modal {
    transform: none;
    transition: opacity 150ms ease;
  }
}
```

Animate backdrop opacity in the same window. **JS:** `showModal()` / `close()` only — no custom focus trap if the dialog already provides one.

---

## Panel reveal

**Purpose:** spatial consistency. **Frequency:** occasional. Use when the panel is **in a region**, not a page overlay (that is modal or drawer).

Prefer percentage translate (`translateY(100%)`) over magic pixels. Optional 2px blur on the enter only; drop blur on reduced motion.

```css
.region {
  overflow: hidden;
}

.panel {
  transform: translateY(0);
  opacity: 1;
  transition:
    transform var(--duration-drawer) var(--ease-drawer),
    opacity var(--duration-drawer) var(--ease-out);
}

.panel.is-closed {
  transform: translateY(100%);
  opacity: 0;
  transition-duration: 350ms;
}

@media (prefers-reduced-motion: reduce) {
  .panel {
    transform: none;
    transition: opacity 200ms ease;
  }
}
```

**JS:** none for class toggle. Drag-to-dismiss → `fluid-interfaces`, not this recipe.

---

## Page side-by-side

**Purpose:** spatial consistency. **Frequency:** occasional (wizard, list/detail). **Not** for primary app nav used 100+/day.

Two siblings in a clipped frame. Forward and back are **symmetric** (`--duration-modal` both ways). Prefer a small translate (~8px) + fade over a full-width slide. Server/HTMX: swap with a direction attribute.

```html
<div class="pager" data-page="list">
  <section data-page-id="list">…</section>
  <section data-page-id="detail">…</section>
</div>
```

```css
.pager {
  display: grid;
}

.pager > section {
  grid-area: 1 / 1;
  transition:
    opacity var(--duration-modal) var(--ease-out),
    transform var(--duration-modal) var(--ease-out);
}

.pager[data-page="list"] > [data-page-id="detail"],
.pager[data-page="detail"] > [data-page-id="list"] {
  opacity: 0;
  pointer-events: none;
}

.pager[data-page="detail"] > [data-page-id="list"] {
  transform: translateX(-8px);
}

.pager[data-page="list"] > [data-page-id="detail"] {
  transform: translateX(8px);
}
```

Do not add a client router. Prefer two URLs + server HTML when the screens are real pages.

---

## Accordion

**Purpose:** prevent jarring change. **Frequency:** occasional.

Native `<details>` / `<summary>`. Height via grid `0fr` / `1fr`. Chevron flips with `scaleY(-1)` — do not morph SVG `d` (Chromium-only). Symmetric duration (`--duration-popover` both ways).

```html
<details class="acc">
  <summary>Filters <span class="acc-chevron" aria-hidden="true">…</span></summary>
  <div class="acc-panel"><div class="acc-inner">…</div></div>
</details>
```

```css
.acc-panel {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows var(--duration-popover) var(--ease-out);
}

.acc[open] > .acc-panel {
  grid-template-rows: 1fr;
}

.acc-inner {
  overflow: hidden;
  min-height: 0;
}

.acc-chevron {
  display: inline-block;
  transition: transform var(--duration-popover) var(--ease-out);
}

.acc[open] .acc-chevron {
  transform: scaleY(-1);
}
```

Pad `.acc-inner`, never the `0fr` track. **JS:** none.

---

## Toast

**Purpose:** feedback. **Frequency:** occasional.

Enter from the same edge it will leave. `@starting-style` when the node is inserted; HTMX: render `is-closed`, then drop it after settle. Open may be slightly slower than close.

```css
.toast {
  opacity: 1;
  transform: translateY(0);
  transition:
    opacity 350ms var(--ease-out),
    transform 350ms var(--ease-out);
}

.toast.is-closed {
  opacity: 0;
  transform: translateY(16px) scale(var(--scale-enter));
  transition-duration: 200ms;
}

@starting-style {
  .toast {
    opacity: 0;
    transform: translateY(16px);
  }
}

@media (prefers-reduced-motion: reduce) {
  .toast {
    transform: none;
    transition: opacity 200ms ease;
  }
}
```

Do not restart keyframes when a second toast arrives — transitions retarget. Skip blur unless a swap flashes; keep blur ≤ 2px.

---

## Tooltip

**Purpose:** feedback. **Frequency:** tens/day → keep tiny or skip.

Pure CSS. Intent delay ~80ms on enter; **no delay** on leave. Gate hover. `transform-origin` toward the trigger.

```html
<span class="tip-wrap">
  <button type="button" aria-describedby="tip-save">Save</button>
  <span class="tip" id="tip-save" role="tooltip">Save draft</span>
</span>
```

```css
.tip {
  position: absolute;
  opacity: 0;
  transform: scale(0.98);
  transform-origin: 50% 100%;
  pointer-events: none;
  transition:
    opacity 50ms var(--ease-out),
    transform 50ms var(--ease-out);
}

@media (hover: hover) and (pointer: fine) {
  .tip-wrap:hover .tip,
  .tip-wrap:focus-within .tip {
    opacity: 1;
    transform: scale(1);
    transition-duration: var(--duration-tooltip);
    transition-delay: 80ms;
  }
}
```

Style colors from host tokens, not hardcoded light-theme hex.

---

## Plus → menu morph

**Purpose:** spatial consistency. **Frequency:** occasional. Only when the **same element** becomes the panel. If the menu is a separate popover, use **menu dropdown**.

Animate `transform` + `border-radius` + opacity of the panel; do not tween large `width`/`height` if a scale from the FAB works. Open `--duration-modal`; close shorter; no bounce on close.

```html
<div class="compose" data-open="false">
  <button type="button" class="compose-fab" aria-expanded="false">Add</button>
  <div class="compose-panel">…</div>
</div>
```

Keep the closed control usable without JS (link or form). Script only to toggle `data-open` / `aria-expanded` if `:has()` / checkbox cannot.
