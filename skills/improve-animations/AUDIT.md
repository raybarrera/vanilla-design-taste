# Motion Audit Categories

Use during `improve-animations` Phase 2.  
Standards from [references/motion-tokens.md](references/motion-tokens.md) and [review-animations/STANDARDS.md](../review-animations/STANDARDS.md).  
Doctrine inspired by Emil Kowalski; stack constraints are this pack’s. [ATTRIBUTION.md](references/ATTRIBUTION.md).

## 1. Purpose and frequency

- Animation on keyboard or 100+/day surfaces  
- Motion with no named purpose  
- Decorative motion on dense functional UI  

## 2. Easing and duration

- `ease-in` on UI enter/exit  
- Weak built-in curves on deliberate motion  
- UI durations over 300ms without reason  
- `transition: all`  

## 3. Physicality and origin

- `scale(0)` entrances  
- Popovers scaling from center when trigger-anchored  
- Missing press feedback on primary controls  
- Asymmetric enter/exit paths that confuse spatial model  

## 4. Interruptibility

- Keyframes on rapidly re-triggered UI  
- Exit/enter that cannot retarget mid-flight when users spam the control  

## 5. Performance

- Animating width/height/top/left/margin/padding casually  
- Per-frame parent CSS variable updates affecting large subtrees  
- Heavy blur/filter on large surfaces  
- Layout thrash in scroll handlers  

## 6. Accessibility

- Movement without `prefers-reduced-motion` consideration  
- Hover-only motion without fine-pointer gating  
- Motion as the only state cue  

## 7. Cohesion and tokens

- One-off curves that ignore existing tokens  
- Parallel motion systems  
- Personality mismatch (bouncy dashboard chrome, etc.)  

## 8. Stack discipline (this pack)

- New Tailwind/Sass/CSS-in-JS introduced for motion  
- New React/Vue island only for animation  
- New Framer Motion / GSAP / similar for problems CSS solves  
- Copy-pasted React recipe leftovers (`useEffect` mount flags) where class toggles suffice  

## 9. Missed opportunities (additive)

List separately from defects: press feedback gaps, occasional jarring swaps, rare delight moments. Still run the frequency gate.
