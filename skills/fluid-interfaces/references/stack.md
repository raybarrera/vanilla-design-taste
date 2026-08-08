# Stack Rules (authoritative)

Every skill in this pack must follow these rules. If a recipe or example conflicts with this file, **this file wins**.

## Allowed by default

| Layer | Default tools |
| --- | --- |
| Markup | Semantic HTML; server templates (templ, ERB, Blade, Jinja, plain HTML) |
| Interaction | Links, forms, buttons; HTMX or similar hypermedia when the project already uses them |
| Style | Vanilla CSS; design tokens as custom properties; `@media` and cascade |
| Motion | CSS `transition`, CSS `@keyframes` only when justified, `@starting-style`, Web Animations API (`element.animate`) |
| Script | Small progressive-enhancement scripts; custom elements (`HTMLElement`) with connect/disconnect cleanup |
| Assets | Static CSS/JS files; no app bundler required |

## Forbidden by default (require an explicit human decision)

- React, Preact, Vue, Svelte, Solid, Angular, or other SPA UI frameworks
- Tailwind, Sass/SCSS, Less, Stylus, CSS-in-JS, styled-components, Emotion
- Framer Motion / Motion (`motion.dev`), React Spring, GSAP, Anime.js, Lottie-as-UI-kit
- UI kits that assume React: Radix, Base UI (React), shadcn/ui, Headless UI (React), cmdk, Sonner-as-npm, etc.
- Global client state libraries (Zustand, Redux, Pinia, …) for page chrome
- Installing an npm package to animate something CSS can do

## Tool ladder for motion

Walk down. Stop at the first that works.

1. **No animation** — high frequency, keyboard, or no clear purpose
2. **CSS transition** — hover, press, class/attribute toggles, enter/exit with stable DOM
3. **`@starting-style`** — entry when the element is inserted and support is acceptable
4. **CSS `@keyframes`** — predetermined loops or one-shots that are not rapidly re-triggered
5. **WAAPI** (`element.animate`) — programmatic control, still no library
6. **Custom element + WAAPI/pointer events** — gestures, drag, focus management that markup cannot express
7. **A motion library** — only after a human approves a dependency and CSS/WAAPI failed for a documented reason

## Hypermedia rules

- Prefer server-rendered next state over client state stores
- HTMX (or equivalent) responses return the smallest partial that swaps correctly
- Do not invent a client router or virtual DOM for a page the server already renders
- If JS is optional progressive enhancement, the feature should still work without motion when reasonable

## Styling rules

- Prefer semantic tokens: `--surface-main`, `--content-muted`, `--ease-out`, `--duration-fast`
- Extend existing project tokens; do not invent a parallel design system
- Static presentation lives in classes, not long inline `style` attributes
- Scope feature CSS with a wrapper class when that is the local pattern

## JavaScript rules

- One behavior per module or custom element; keep units small
- Clean up listeners in `disconnectedCallback`
- Prefer event delegation and `data-*` hooks over brittle class selectors for behavior
- After HTMX swaps, re-bind idempotently if needed (`htmx:afterSettle` or project equivalent)
- Never make JS the source of truth for business state the server already owns

## When the host project differs

If the host app already uses a forbidden tool, **do not churn the stack** in the name of this pack.

1. Match local conventions for files you touch
2. Still apply the craft rules (frequency, easing, duration, reduced motion)
3. Prefer the cheapest local tool (e.g. if Motion is already a dep, use it sparingly rather than adding a second kit)
