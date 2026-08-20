# Feedback

Shared tokens: [../references/motion-tokens.md](../references/motion-tokens.md).  
Stack: [../references/stack.md](../references/stack.md).

---

## Notification badge

**Purpose:** state indication. **Frequency:** occasional (new count). Do **not** bounce the trigger.

Animate only the badge: short diagonal translate + scale from `--scale-enter`, opacity. Pop overshoot is **delight** — skip on admin chrome; use a 200ms ease-out scale instead.

```html
<button type="button" class="inbox" style="position: relative">
  Inbox
  <span class="badge" data-open="true">3</span>
</button>
```

```css
.badge {
  position: absolute;
  opacity: 0;
  transform: translate(-6px, 8px) scale(var(--scale-enter));
  transition:
    opacity 180ms var(--ease-out),
    transform 200ms var(--ease-out);
}

.badge[data-open="true"] {
  opacity: 1;
  transform: translate(0, 0) scale(1);
}
```

Close faster than open. Reduced motion: opacity only.

---

## Error shake

**Purpose:** feedback. **Frequency:** occasional (validation). Keyboard submit may still shake **once** if it is the error reveal — do not shake on every keystroke.

Keep travel tiny (4–8px). Short keyframe (under ~250ms total). Border/message color is host tokens. Auto-revert of the shake is fine; do **not** auto-hide the error text before the user can read it.

```html
<div class="field" data-invalid="true">
  <label>Email <input type="email" class="field-control"></label>
  <p class="field-error">Enter a valid email.</p>
</div>
```

```css
@keyframes field-shake {
  20% { transform: translateX(-6px); }
  40% { transform: translateX(5px); }
  60% { transform: translateX(-3px); }
  80% { transform: translateX(2px); }
  100% { transform: translateX(0); }
}

.field[data-invalid="true"] .field-control.is-shaking {
  animation: field-shake 240ms var(--ease-out);
}

@media (prefers-reduced-motion: reduce) {
  .field[data-invalid="true"] .field-control.is-shaking {
    animation: none;
  }
}
```

Replay: remove `is-shaking`, reflow (`void el.offsetWidth`), re-add. Keep `data-invalid` orthogonal so replay does not flicker the error styling.

**JS:** one class toggle after the server/HTML says the field is invalid. Do not rebuild the input.

---

## Success check

**Purpose:** feedback + rare delight. **Frequency:** rare/first-time (payment, first save). Daily “saved” toasts should use **toast**, not a 500ms rotate+bob.

Prefer opacity + small scale (`--scale-enter` → 1) in `--duration-modal`. Optional SVG stroke-draw: set `stroke-dasharray` from `path.getTotalLength()`, not a copied `20`. Skip large Y-bob (tens of px) and large blur on product UI.

```html
<span class="success" data-state="in" aria-hidden="true">
  <svg viewBox="0 0 24 24" fill="none">
    <path d="M5 12l4 4 10-10" />
  </svg>
</span>
```

```css
.success {
  opacity: 0;
  transform: scale(var(--scale-enter));
  transition:
    opacity var(--duration-modal) var(--ease-out),
    transform var(--duration-modal) var(--ease-out);
}

.success[data-state="in"] {
  opacity: 1;
  transform: scale(1);
}

.success path {
  stroke-dasharray: var(--success-len, 24);
  stroke-dashoffset: var(--success-len, 24);
  transition: stroke-dashoffset var(--duration-modal) var(--ease-out);
}

.success[data-state="in"] path {
  stroke-dashoffset: 0;
}
```

Appear-only is fine; persistent success does not need a fancy exit.

---

## Like button

**Purpose:** feedback; particles are **delight**. **Frequency:** tens/day likes → press scale only (`--scale-press`). Burst only on rare/playful surfaces.

Prefer a real `<button>` or checkbox. Fill via CSS (`fill` / `background`) in `--duration-press`. Un-like: reverse fill, **no** particles.

```css
.like {
  transition: transform var(--duration-press) var(--ease-out);
}

.like:active {
  transform: scale(var(--scale-press));
}

.like[aria-pressed="true"] .like-icon {
  fill: var(--color-danger, currentColor);
  transition: fill var(--duration-press) ease;
}
```

Do not ship eight particle nodes on an admin table.

---

## Checkbox check

**Purpose:** feedback. **Frequency:** tens/day → keep short.

**Native `<input type="checkbox">`**, styled to host field tokens. Optional check-draw on the tick only if the host already uses an SVG tick; calibrate path length. Uncheck is faster than draw.

Do not replace the checkbox with `role="checkbox"` on a `<button>` for looks.

```css
.field-check {
  accent-color: var(--color-accent, currentColor);
  transition: accent-color var(--duration-press) ease;
}

@media (prefers-reduced-motion: reduce) {
  .field-check { transition: none; }
}
```

---

## Toggle

**Purpose:** state indication. **Frequency:** tens/day (settings) → no overshoot.

Styled native checkbox (or `role="switch"` only if a native control truly cannot). Thumb travels with `transform`. Track color on its own clock. **No** double-bounce on product/admin. Skip entrance animation on first paint (`:not(.is-ready)` or `@starting-style` so load does not bounce every switch).

```html
<label class="switch">
  <input type="checkbox" role="switch">
  <span class="switch-ui" aria-hidden="true"></span>
  Notify me
</label>
```

```css
.switch-ui {
  display: inline-block;
  width: 2.5rem;
  height: 1.5rem;
}

.switch-ui::after {
  content: "";
  display: block;
  width: 1.15rem;
  height: 1.15rem;
  transform: translateX(0);
  transition: transform var(--duration-popover) var(--ease-out);
}

.switch input:checked + .switch-ui::after {
  transform: translateX(1rem);
}

@media (prefers-reduced-motion: reduce) {
  .switch-ui::after { transition: none; }
}
```

Travel distance from the control’s own size (`translateX`), not a magic `14.66px`.

---

## Learn more hover

**Purpose:** feedback. **Frequency:** marketing/Brand. Skip on dense admin tables.

Gate with fine pointer. Small translate (~2px) in `--duration-popover`. Do not make the arrow the only sign that the control is a link.

```css
@media (hover: hover) and (pointer: fine) {
  .learn:hover .learn-chevron {
    transform: translateX(2px);
    transition: transform var(--duration-popover) var(--ease-out);
  }
}
```
