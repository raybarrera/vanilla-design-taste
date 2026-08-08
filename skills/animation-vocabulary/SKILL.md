---
name: animation-vocabulary
description: >
  Reverse-lookup glossary: turn a vague description of a web motion effect into
  its precise term so prompts and reviews stay clear. Use when the user asks
  "what's it called when…", describes a motion without knowing the name, or
  runs /animation-vocabulary. Names effects; does not design or implement them.
---

# Animation Vocabulary

Map a felt description to a precise term.

## Inspiration and attribution

Glossary structure and many term definitions are **inspired by** Emil Kowalski’s `animation-vocabulary` skill in [emilkowalski/skills](https://github.com/emilkowalski/skills) and the public vocabulary used in his animation teaching. Wording here is adapted for this pack; when in doubt, prefer Emil’s public explanations at [animations.dev](https://animations.dev/). See [ATTRIBUTION.md](references/ATTRIBUTION.md).

## Output format

```
**Stagger** — Animate several items one after another with a small delay between each, creating a cascade.
```

If several terms fit, best match first, then 1–2 alternates with one-line contrast.

## Instructions

1. Read intent, not keywords.  
2. Prefer glossary wording below.  
3. Disambiguate close pairs.  
4. If nothing matches, say so; approximate with glossary words.  
5. Stay tight — a name, not an essay.

## Glossary

### Entrances and exits

- **Fade in / Fade out** — Appear or disappear by changing opacity.  
- **Slide in** — Enter by moving from off-screen.  
- **Scale in** — Grow from smaller to full size, often with fade.  
- **Pop in** — Appear with slight overshoot / bounce into place.  
- **Reveal** — Uncover gradually (often clip-path or mask).  
- **Enter / Exit** — Motion when adding or removing from the screen.  

### Sequencing

- **Keyframes** — Defined points in time; the browser fills between them.  
- **Interpolation / Tween** — Continuous in-betweens from A to B.  
- **Stagger** — Cascade delays across multiple items.  
- **Orchestration** — Coordinating several motions as one story.  
- **Delay** — Time before motion starts.  
- **Duration** — How long motion takes.  
- **Fill mode** — Whether end/start styles persist outside the animation.  
- **Stepped animation** — Discrete jumps rather than smooth tweening.  

### Transforms

- **Translate** — Move on X/Y.  
- **Scale** — Grow or shrink.  
- **Rotate** — Spin around a point.  
- **Skew** — Shear out of rectangle.  
- **3D tilt / Flip** — rotateX / rotateY depth.  
- **Perspective** — Strength of 3D projection.  
- **Transform origin** — Anchor for scale/rotate.  
- **Origin-aware animation** — Grows from the trigger, not the element center.  

### State transitions

- **Crossfade** — One fades out as another fades in in place.  
- **Continuity transition** — Keeps orientation between before and after.  
- **Morph** — One shape becomes another.  
- **Shared element transition** — Same logical element travels and transforms across views.  
- **Layout animation** — Size/position change animates instead of snapping.  
- **Accordion / Collapse** — Height expands/collapses to show or hide.  
- **Direction-aware transition** — Forward and back use opposite slide directions.  

### Scroll

- **Scroll reveal** — Enter when scrolling into view.  
- **Scroll-driven animation** — Progress tied to scroll position.  
- **Parallax** — Layers move at different scroll speeds.  
- **Page transition** — Motion between full pages/routes.  
- **View transition** — Browser-level morph between states/pages.  

### Feedback

- **Hover effect** — Change under the cursor.  
- **Press / Tap feedback** — Subtle scale-down on activation.  
- **Hold to confirm** — Progress while holding before commit.  
- **Drag** — Move by pointer with optional momentum.  
- **Drag to reorder** — Reorder list items by dragging.  
- **Swipe to dismiss** — Drag off-screen to close.  
- **Rubber-banding** — Resistance and snap-back past a boundary.  
- **Shake / Wiggle** — Quick jitter for error/reject.  
- **Ripple** — Expanding circle from tap point.  

### Easing

- **Easing** — How speed changes over time.  
- **Ease-out** — Fast start, slow end; default for UI response.  
- **Ease-in** — Slow start; usually avoided for UI response.  
- **Ease-in-out** — Slow-fast-slow for on-screen moves.  
- **Linear** — Constant speed; loops/progress.  
- **Cubic-bezier** — Custom curve.  
- **Asymmetric easing** — Different accel/decel shape each way.  

### Springs

- **Spring** — Physics-based motion (tension, mass, damping) rather than fixed duration alone.  
- **Stiffness / Tension** — Pull strength toward target.  
- **Damping** — How fast oscillation dies.  
- **Mass** — Heaviness of the moving value.  
- **Bounce** — Overshoot and settle.  
- **Momentum** — Carried velocity after a gesture.  
- **Velocity** — Speed and direction; used on interrupt.  
- **Interruptible animation** — Can retarget mid-flight smoothly.  

In **this pack**, prefer CSS transitions/WAAPI; reach for spring libraries only with host approval. You can still *name* springy feel when describing a target.

### Ambient

- **Marquee** — Continuous looping scroll of content.  
- **Loop** — Repeating animation.  
- **Alternate (yoyo)** — Forward then reverse each cycle.  
- **Orbit** — Circle around a point.  
- **Pulse** — Gentle repeating scale/opacity.  
- **Float** — Gentle vertical drift.  
- **Idle animation** — Subtle motion while waiting.  

### Polish

- **Blur** — Soften or mask a transition seam.  
- **Clip-path** — Clip to a shape for reveals and holds.  
- **Mask** — Soft-edge hide/reveal.  
- **Before / after slider** — Drag to compare two images.  
- **Line drawing** — SVG path strokes itself.  
- **Text morph** — Characters animate when text changes.  
- **Skeleton / Shimmer** — Loading placeholder sheen.  
- **Number ticker** — Digits roll or count to a value.  
- **Tabular numbers** — Fixed-width digits.  
- **Typewriter** — Characters appear one by one.  

### Performance

- **Frame rate (FPS)** — Frames per second; 60 as baseline smoothness.  
- **Jank** — Visible stutter from dropped work.  
- **Dropped frame** — Missed display deadline.  
- **Compositing** — GPU moves opacity/transform without layout.  
- **will-change** — Hint that animation is imminent.  
- **Layout thrashing** — Animating layout props forces repeated reflow.  

### Principles

- **Purposeful animation** — Motion serves a job, not decoration alone.  
- **Anticipation** — Small wind-up before a move.  
- **Follow-through** — Settle after the main motion.  
- **Squash and stretch** — Deform to show weight/speed.  
- **Perceived performance** — Motion that makes waits feel shorter.  
- **Frequency of use** — More frequent → shorter/subtler/none.  
- **Spatial consistency** — Keep identity and path clear across states.  
- **Hardware acceleration** — Prefer transform/opacity.  
- **Reduced motion** — Honor user preference for less movement.  
