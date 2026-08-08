# Prototype Picker Chrome

Copy this structure when building the harness. It is chrome, not a design variant.

## Markup

```html
<div class="vdt-proto" data-vdt-proto>
  <div class="vdt-proto__stage" data-vdt-stage>
    <!-- one variant root visible at a time -->
    <section class="vdt-proto__variant" data-variant="0" hidden>…</section>
    <section class="vdt-proto__variant" data-variant="1" hidden>…</section>
    <section class="vdt-proto__variant" data-variant="2" hidden>…</section>
  </div>

  <nav class="vdt-proto__bar" aria-label="Prototype variants">
    <button type="button" data-vdt-prev aria-label="Previous variant">←</button>
    <p class="vdt-proto__label" data-vdt-label>1 / 3 — Quiet</p>
    <button type="button" data-vdt-next aria-label="Next variant">→</button>
  </nav>
</div>
```

## Styles (fixed chrome look)

```css
.vdt-proto {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: #111;
  color: #f5f5f5;
  font: 14px/1.4 system-ui, sans-serif;
}

.vdt-proto__stage {
  flex: 1;
  display: grid;
  place-items: center;
  padding: 2rem;
  background: #1a1a1a;
}

.vdt-proto__variant {
  width: min(100%, 72rem);
}

.vdt-proto__bar {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  padding: 0.75rem 1rem;
  border-top: 1px solid #333;
  background: #0a0a0a;
}

.vdt-proto__bar button {
  appearance: none;
  border: 1px solid #444;
  background: #222;
  color: inherit;
  border-radius: 0.375rem;
  padding: 0.4rem 0.75rem;
  cursor: pointer;
}

.vdt-proto__label {
  margin: 0;
  min-width: 12rem;
  text-align: center;
  font-variant-numeric: tabular-nums;
}
```

Do not theme this bar to match product variants.

## Behavior

```js
(function () {
  const root = document.querySelector("[data-vdt-proto]");
  if (!root) return;

  const variants = [...root.querySelectorAll("[data-variant]")];
  const label = root.querySelector("[data-vdt-label]");
  const names = variants.map((el) => el.dataset.name || el.getAttribute("aria-label") || "Variant");
  let i = 0;

  function show(next) {
    i = (next + variants.length) % variants.length;
    variants.forEach((el, idx) => {
      el.hidden = idx !== i;
    });
    if (label) label.textContent = i + 1 + " / " + variants.length + " — " + names[i];
  }

  root.querySelector("[data-vdt-prev]")?.addEventListener("click", () => show(i - 1));
  root.querySelector("[data-vdt-next]")?.addEventListener("click", () => show(i + 1));
  window.addEventListener("keydown", (e) => {
    if (e.key === "ArrowLeft") show(i - 1);
    if (e.key === "ArrowRight") show(i + 1);
  });

  show(0);
})();
```

Keys: **← / →**. Switching is instant — no transition on the stage swap.

Put `data-name="Quiet"` on each variant section for the label.
