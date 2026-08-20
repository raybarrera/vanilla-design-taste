# Motion Tokens

Shared curves, durations, and physical defaults used by every skill in this pack.

**Attribution:** Duration bands, “never ease-in on UI,” “never scale(0),” strong ease-out curves, and press-scale feedback are craft defaults taught publicly by [Emil Kowalski](https://emilkowal.ski/) (see [animations.dev](https://animations.dev/), [7 Practical Animation Tips](https://emilkowal.ski/ui/7-practical-animation-tips), and [emilkowalski/skills](https://github.com/emilkowalski/skills)). We use them here as attributed standards, expressed as vanilla CSS tokens.

## Prefer project tokens first

If the host app already defines `--ease-out`, `--duration-fast`, etc., **use those**. Only introduce the variables below when the project has no motion scale yet.

## Suggested CSS custom properties

```css
:root {
  /* Strong curves — built-in ease-out is often too soft for deliberate UI */
  --ease-out: cubic-bezier(0.23, 1, 0.32, 1);
  --ease-in-out: cubic-bezier(0.77, 0, 0.175, 1);
  --ease-drawer: cubic-bezier(0.32, 0.72, 0, 1); /* iOS-like sheet feel (Ionic family) */

  --duration-press: 160ms;
  --duration-tooltip: 150ms;
  --duration-popover: 200ms;
  --duration-modal: 250ms;
  --duration-drawer: 400ms;

  --scale-press: 0.97;
  --scale-enter: 0.95;
}
```

## Easing decision table

| Situation | Easing |
| --- | --- |
| Entering or exiting | `var(--ease-out)` |
| Moving / morphing already on screen | `var(--ease-in-out)` |
| Hover or color change | `ease` (or a soft custom) |
| Constant motion (spinner, marquee) | `linear` |
| Default when unsure | `var(--ease-out)` |

**Never use `ease-in` for UI that responds to the user.** It delays the first visible motion — the moment they are watching.

## Duration budgets

| Element | Duration |
| --- | --- |
| Button / press feedback | 100–160ms |
| Tooltips, small popovers | 125–200ms |
| Dropdowns, menus, selects | 150–250ms |
| Modals | 200–300ms |
| Drawers / sheets | 200–500ms |
| Marketing / explanatory | May be longer |

**UI motion should usually stay under 300ms** unless it is a deliberate sheet or rare delight moment.

## Open / close asymmetry

Opening is the invitation. Closing should get out of the way.

| Surface | Open | Close |
| --- | --- | --- |
| Tooltip | `--duration-tooltip` after a short intent delay | Faster than open; **no delay** |
| Dropdown / popover | `--duration-popover` | Shorter (~150ms) |
| Modal | `--duration-modal` | Shorter (~150–200ms) |
| Drawer / sheet | `--duration-drawer` | Slightly shorter |
| Toast | Personality; often ~300–400ms in | Faster out |

Do **not** bounce a close. Overshoot belongs to rare entrances only.

Keep **the same duration both ways** when the motion is one reversible path, not an open/close pair: page slide, sliding tabs pill, accordion height, icon swap, in-place text swap.

## Intent delay

A tooltip (or similar hover hint) may wait ~80ms before appearing so a passing pointer does not trigger it. Use delay to filter accidents or sequence two beats — not to pad a slow animation. **Never delay a close or a hover-out.**

If motion feels late, shorten **duration** before adding delay.

## Frequency gate

| How often the user sees it | Decision |
| --- | --- |
| 100+ times/day (keyboard shortcuts, command palette, core nav toggle) | **No animation** |
| Tens of times/day (list hover, frequent toggles) | Near-imperceptible or none |
| Occasional (modals, drawers, toasts) | Standard budgets above |
| Rare / first-time (onboarding, celebration) | Delight budget lives here |

Keyboard-initiated actions: **never animate**. High repetition makes motion feel like lag.

## Physical defaults

| Rule | Value / practice |
| --- | --- |
| Never enter from `scale(0)` | Start at `scale(0.9–0.97)` + `opacity: 0` |
| Press feedback | `transform: scale(var(--scale-press))` on `:active` |
| Animate only | `transform` and `opacity` (layout props are a last resort) |
| Popovers | `transform-origin` toward the trigger; modals stay centered |
| Name properties | Never `transition: all` |
| Stagger | 30–80ms between items; never block interaction |

## Reduced motion and pointer

```css
@media (prefers-reduced-motion: reduce) {
  /* Keep short opacity/color; drop travel and bounce */
}

@media (hover: hover) and (pointer: fine) {
  /* Hover scale/lift only here — touch fires false hovers */
}
```

Reduced motion means **gentler**, not always zero. Keep transitions that aid comprehension.

## Purpose vocabulary

Every animation must name one purpose before it ships:

- **Feedback** — the UI heard the user
- **Spatial consistency** — where something came from or went
- **State indication** — a change is legible
- **Prevent jarring change** — bridge a teleport
- **Explanation** — marketing/onboarding only
- **Delight** — rare/first-time tier only

If the only answer is “looks cool” on a frequent surface, do not animate.
