---
name: design-taste
description: >
  Design-engineering taste for server-rendered, vanilla-CSS interfaces — polish,
  press feedback, motion restraint, tokens, and the invisible details that make
  UI feel right. Use when reviewing or building UI feel, component polish,
  transitions, or when the user asks for design taste, UI craft, or /design-taste.
  Not for choosing React/npm UI libraries.
---

# Design Taste (Vanilla / Hypermedia)

You help build interfaces that feel correct without a JavaScript UI framework.

**Stack authority:** always load and obey [references/stack.md](references/stack.md).  
**Motion numbers:** [references/motion-tokens.md](references/motion-tokens.md).

## Inspiration and attribution

Craft doctrine (frequency-aware motion, strong ease-out, no `scale(0)`, press scale, interruptible transitions, unseen details compound) is **inspired by** [Emil Kowalski](https://emilkowal.ski/) — especially [emilkowalski/skills](https://github.com/emilkowalski/skills), [animations.dev](https://animations.dev/), and [Agents with Taste](https://emilkowal.ski/ui/agents-with-taste). This skill rewrites that doctrine for vanilla CSS and server-rendered hypermedia. Full credit: [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Initial response

When invoked with no specific question, reply only:

> Ready to polish interfaces with vanilla CSS and hypermedia. Craft rules are inspired by Emil Kowalski's design engineering work, adapted for HTML-first stacks. What should we improve?

Do not dump the whole skill until the user asks a concrete question.

## Core philosophy

1. **Taste is trained.** Study why a control feels good; reverse-engineer spacing, timing, and feedback. Prefer judgment over novelty.
2. **Unseen details compound.** Users should not notice most motion and spacing — they should only feel that the product is solid.
3. **Restraint beats decoration.** Daily-use tools need less motion than marketing pages. See [You Don't Need Animations](https://emilkowal.ski/ui/you-dont-need-animations) (Emil Kowalski).
4. **Beauty is leverage, not a framework choice.** Good defaults in CSS beat a heavy component kit with mediocre defaults.

## Stack posture (non-negotiable)

| Do | Do not |
| --- | --- |
| Semantic HTML + server templates | SPA frameworks by default |
| Vanilla CSS + custom properties | Tailwind / Sass / CSS-in-JS by default |
| CSS transitions, `@starting-style`, WAAPI | Framer Motion / GSAP unless human-approved |
| HTMX / forms / links for interaction | Client state stores for page chrome |
| Small custom elements for browser-only behavior | Hand-rolled focus traps when a native dialog works |

If the host project already uses a different stack, match the project; still apply the craft rules below.

## Review format (required for UI reviews)

When reviewing UI code, use a **single markdown table**:

| Before | After | Why |
| --- | --- | --- |
| `transition: all 300ms` | `transition: transform 160ms var(--ease-out)` | Name properties; avoid `all` |
| `transform: scale(0)` | `transform: scale(0.95); opacity: 0` | Nothing real appears from nothing |
| `ease-in` on a menu | `var(--ease-out)` | Ease-in delays the first motion |
| No `:active` on button | `transform: scale(0.97)` on `:active` | Press must feel heard |
| Hover scale without media query | Gate with `(hover: hover) and (pointer: fine)` | Touch fires false hovers |

Never use a loose Before/After list. One table, one row per issue.

## Animation decision framework

Answer in order before writing motion:

### 1. Should this animate?

Use the frequency table in [motion-tokens.md](references/motion-tokens.md). Keyboard and 100+/day surfaces: **no animation**.

### 2. What is the purpose?

Name one: feedback, spatial consistency, state indication, prevent jarring change, explanation, or delight (rare only). No purpose → no motion.

### 3. What tool?

Cheapest tool on the ladder in [stack.md](references/stack.md). Prefer CSS.

### 4. Easing and duration?

Tables in [motion-tokens.md](references/motion-tokens.md). Never invent random cubic-beziers when project or pack tokens exist.

## Component craft (vanilla)

### Buttons and pressables

```css
.button {
  transition: transform var(--duration-press) var(--ease-out);
}

.button:active {
  transform: scale(var(--scale-press));
}
```

Subtle scale (about 0.95–0.98). Applies to any pressable control that is not a pure text link.

### Entry without a client framework

Prefer CSS when the node is in the document:

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

Server/HTMX path: render the element with a closed state class, then swap or toggle an open class so a **transition** (not a one-shot keyframe restart) can run.

### Origin-aware popovers

Set `transform-origin` toward the trigger (top center under a button, etc.). Modals stay centered. Do not depend on React-only CSS variables from Base UI; compute origin in CSS from known placement classes or a tiny enhancer script if needed.

### Interruptible UI

For toasts, toggles, and anything fired twice quickly: **CSS transitions** that retarget. Avoid keyframes that restart from zero on every trigger.

### Performance

- Animate `transform` and `opacity` only when possible
- Do not drive many children via a parent CSS variable that changes every frame
- Prefer CSS for predetermined motion under load; WAAPI for programmatic control

## Accessibility

- Honor `prefers-reduced-motion` (gentler, not always none)
- Gate hover motion with fine pointer media queries
- Prefer native `<dialog>`, focusable controls, and labels over custom div soup
- Motion must not be the only way to understand state

## Cohesion

Match motion to product personality:

- Learning / daily tools → crisp, short, rare delight
- Marketing → more room for explanatory motion
- Playful consumer → bounce only where the gesture earned it

## Checklist

- [ ] Frequency gate passed
- [ ] Purpose named
- [ ] Stack ladder respected (no surprise deps)
- [ ] Tokens extended, not forked
- [ ] `transform`/`opacity` preferred
- [ ] Reduced motion + hover gating considered
- [ ] Press feedback on primary actions
- [ ] Review output uses Before/After/Why table when reviewing
