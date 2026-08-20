# Content

Shared tokens: [../references/motion-tokens.md](../references/motion-tokens.md).  
Stack: [../references/stack.md](../references/stack.md).

---

## Number pop-in

**Purpose:** state indication. **Frequency:** occasional (a total that changes). **Refuse** on live tickers and keyboard-driven increments.

Prefer tabular numbers and a short opacity + `translateY(4–8px)` on the value. Per-digit stagger only when the number is a rare event; cap total stagger under ~300ms. Do not use a 500ms bounce on dashboard KPIs.

```html
<p class="metric"><span class="metric-value">128</span></p>
```

```css
.metric-value.is-updating {
  animation: metric-in 200ms var(--ease-out);
}

@keyframes metric-in {
  from {
    opacity: 0;
    transform: translateY(6px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (prefers-reduced-motion: reduce) {
  .metric-value.is-updating { animation: none; }
}
```

Replay: remove the class, reflow, re-add after the text swap. **JS:** only to swap text + toggle the class when the server did not render the new node.

If the change must feel like a jackpot, see **spinning counter** (delight only).

---

## Text states swap

**Purpose:** prevent jarring change. **Frequency:** occasional (“Save” → “Saved”). Symmetric, short (`--duration-tooltip` / ~150ms), `ease-in-out` for on-screen morph.

Two stacked spans, or one node with an exit/enter class. Travel ~4px. Optional 2px blur; drop blur under reduced motion.

```html
<button type="submit" class="save" data-state="idle">
  <span class="save-a">Save</span>
  <span class="save-b">Saved</span>
</button>
```

```css
.save {
  display: inline-grid;
}

.save > span {
  grid-area: 1 / 1;
  transition:
    opacity var(--duration-tooltip) var(--ease-in-out),
    transform var(--duration-tooltip) var(--ease-in-out);
}

.save[data-state="idle"] .save-b,
.save[data-state="done"] .save-a {
  opacity: 0;
  transform: translateY(-4px);
  pointer-events: none;
}
```

Prefer this over JS `textContent` choreography when both labels are known.

---

## Icon swap

**Purpose:** state indication. **Frequency:** occasional (theme, play/pause). Symmetric `--duration-popover`.

Keep **both** icons in the DOM. Crossfade opacity. Scale from `--scale-enter`, **never** `0.25` or `0`. Optional 2px blur.

```html
<button type="button" class="icon-swap" data-state="sun" aria-label="Theme">
  <span data-icon="sun">…</span>
  <span data-icon="moon">…</span>
</button>
```

```css
.icon-swap {
  display: inline-grid;
}

.icon-swap > span {
  grid-area: 1 / 1;
  transition:
    opacity var(--duration-popover) var(--ease-in-out),
    transform var(--duration-popover) var(--ease-in-out);
}

.icon-swap[data-state="sun"] > [data-icon="moon"],
.icon-swap[data-state="moon"] > [data-icon="sun"] {
  opacity: 0;
  transform: scale(var(--scale-enter));
  pointer-events: none;
}
```

---

## Skeleton reveal

**Purpose:** prevent jarring change. **Frequency:** occasional (first load of a panel).

Pulse with `opacity` + `linear` (or a tokenized skeleton color). When content is ready, crossfade in `--duration-popover`–`--duration-drawer`. Keep skeleton and content in the **same slot** so layout does not jump. One pulse loop is enough; do not shimmer forever on a failed load — show the error state.

```html
<div class="skel" data-state="loading">
  <div class="skel-placeholder"></div>
  <div class="skel-content">…</div>
</div>
```

```css
.skel {
  display: grid;
}

.skel > * {
  grid-area: 1 / 1;
  transition: opacity var(--duration-drawer) var(--ease-in-out);
}

.skel[data-state="loading"] .skel-content,
.skel[data-state="ready"] .skel-placeholder {
  opacity: 0;
  pointer-events: none;
}

.skel-placeholder {
  animation: skel-pulse 1s linear infinite;
}

@keyframes skel-pulse {
  50% { opacity: 0.55; }
}

@media (prefers-reduced-motion: reduce) {
  .skel-placeholder { animation: none; }
}
```

HTMX: swap the partial to `data-state="ready"` after settle.

---

## Shimmer text

**Purpose:** state indication. **Frequency:** only while waiting. **Refuse** as decoration on static headlines.

Pure CSS gradient on a `background-clip: text` label, `linear`, long duration (~2s). Honor reduced motion by dropping the loop (static muted color). Colors from host tokens, not hardcoded `#7c7c7c`.

```css
.thinking {
  background: linear-gradient(
    90deg,
    var(--content-muted) 0%,
    var(--content-main) 50%,
    var(--content-muted) 100%
  );
  background-size: 200% 100%;
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  animation: thinking-sheen 2s linear infinite;
}

@keyframes thinking-sheen {
  to { background-position: -200% 0; }
}

@media (prefers-reduced-motion: reduce) {
  .thinking {
    animation: none;
    color: var(--content-muted);
    background: none;
  }
}
```

Do not duplicate the string into `data-text` unless a mask trick truly needs it.

---

## Texts reveal

**Purpose:** explanation or delight. **Frequency:** rare (hero, empty success, onboarding). **Refuse** on daily dashboards.

Stagger 30–80ms; total stagger under ~300ms. Enter: opacity + small `translateY`. Exit: quiet fade, **no** reverse stagger. Reduced motion: opacity only.

```css
.hero-line {
  opacity: 0;
  transform: translateY(8px);
  transition:
    opacity 400ms var(--ease-out),
    transform 400ms var(--ease-out);
}

.hero.is-shown .hero-line { opacity: 1; transform: none; }
.hero-line:nth-child(2) { transition-delay: 40ms; }
.hero-line:nth-child(3) { transition-delay: 80ms; }

.hero.is-hiding .hero-line {
  opacity: 0;
  transform: none;
  transition-delay: 0ms;
  transition-duration: 200ms;
}

@media (prefers-reduced-motion: reduce) {
  .hero-line { transform: none; transition: opacity 200ms ease; }
}
```

Never block clicks while stagger plays.

---

## Spinning counter

**Purpose:** delight. **Frequency:** rare only (celebration, marketing). **Refuse** on operator dashboards, prices that tick, anything keyboard-incremented.

If the user still wants it: CSS `transform` on digit strips, duration well under a showpiece 1.4s unless Brand mode — prefer ~400–600ms and few spins. Prefer **number pop-in** whenever the change is informational.

**JS:** building reel columns is justified *if* this recipe passed the gate. Clean up on disconnect. Do not pull a count-up npm library.
