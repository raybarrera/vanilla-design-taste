# Animation Standards Reference

Precise values for reviews. Prefer host project tokens when they exist.

**Attribution:** Frequency gates, easing tables, duration bands, and physical rules are craft standards taught publicly by [Emil Kowalski](https://emilkowal.ski/) and reflected in [emilkowalski/skills](https://github.com/emilkowalski/skills). This file states them for vanilla CSS stacks. See [ATTRIBUTION.md](../../ATTRIBUTION.md).

Also read [references/motion-tokens.md](../../references/motion-tokens.md) and [references/stack.md](../../references/stack.md).

## Frequency

| Frequency | Decision |
| --- | --- |
| 100+/day (keyboard, palette, core toggles) | No animation |
| Tens/day | Remove or make near-imperceptible |
| Occasional | Standard budgets |
| Rare / first-time | Delight allowed |

## Easing

| Situation | Easing |
| --- | --- |
| Enter / exit | Strong ease-out: `cubic-bezier(0.23, 1, 0.32, 1)` |
| On-screen move | Strong ease-in-out: `cubic-bezier(0.77, 0, 0.175, 1)` |
| Hover / color | `ease` |
| Loops / progress | `linear` |
| Drawers | `cubic-bezier(0.32, 0.72, 0, 1)` |

Never `ease-in` on UI response motion.

## Duration

| Element | Budget |
| --- | --- |
| Press | 100–160ms |
| Tooltip | 125–200ms |
| Menu / popover | 150–250ms |
| Modal | 200–300ms |
| Drawer | 200–500ms |

UI default ceiling: **300ms**.

## Physicality

- No `scale(0)` — use ~0.95 + opacity  
- Press: `scale(0.97)` on `:active`  
- Popover origin toward trigger; modal center  
- Prefer `transform` / `opacity`  
- No `transition: all`  

## Interruptibility

- Rapid UI → CSS transitions  
- Entry: `@starting-style` or class toggle transitions  
- Gestures → WAAPI / custom element; springs libraries only if already in host  

## Performance

- Avoid layout props for casual animation  
- Do not update parent custom props every frame to move children  
- CSS off-main-thread for predetermined motion; WAAPI for programmatic  

## Accessibility

```css
@media (prefers-reduced-motion: reduce) { /* gentler */ }
@media (hover: hover) and (pointer: fine) { /* hover only */ }
```

## Stack (this pack)

Findings if the change introduces, without human approval:

- Tailwind / Sass / CSS-in-JS for the motion work  
- React/Vue/etc. only to get enter/exit  
- Framer Motion, GSAP, or similar for a fade/press  

## Debugging recommendations

When feel is uncertain: slow motion 2–5×, DevTools Animation inspector, real device for gestures, re-check next day.
