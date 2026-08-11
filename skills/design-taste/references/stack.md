# Stack Rules (authoritative)

Every skill in this pack must follow these rules. If a recipe or example conflicts with this file, **this file wins**.

## Allowed by default

| Layer | Default tools |
| --- | --- |
| Markup | Semantic HTML; server templates (templ, ERB, Blade, Jinja, plain HTML) |
| Interaction | Links, forms, buttons; HTMX or similar hypermedia when the project already uses them |
| Style | Vanilla CSS; design tokens as custom properties; `@media` and cascade |
| Motion | CSS `transition`, CSS `@keyframes` only when justified, `@starting-style`, Web Animations API (`element.animate`) |
| Script | **None by default.** Add JS only when HTML/CSS (and optional hypermedia) cannot deliver a good affordance |
| Assets | Static CSS/HTML; JS files only when justified (see ladder below); no app bundler required |

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
- **Native controls must look like the product.** Prefer native form elements, then style them with host tokens (shared field system). Unstyled browser chrome next to designed UI is not “following the stack” — see [visual-craft.md](./visual-craft.md) § *Native form controls*. Do not replace native controls with JS widgets only for looks.

## JavaScript minimization (non-negotiable posture)

**Default: no JavaScript.** Skills and samples must try hard to ship affordances with semantic HTML + CSS (+ server/HTMX when the host has it). JS is a last resort for a specific gap — not a default layer for “interactivity.”

### Affordances ladder

Walk down. Stop at the first that is good enough:

1. **Native HTML** — links, forms, GET filters, `<dialog>`, `<details>`, `<summary>`, checkboxes/radios, labels, `popover` / `popovertarget`, invoker commands where supported — **styled to the product** (not left as browser defaults)  
2. **CSS** — `:has()`, `:target`, `:focus-within`, `@media`, `@starting-style`, scroll-driven animations, checkbox/radio-driven UI, pure-CSS show/hide  
3. **Hypermedia** — server-rendered next state; HTMX (or host equivalent) partials; URL as state  
4. **Tiny progressive enhancement** — only if 1–3 cannot provide a *top-notch* affordance (e.g. drag-to-dismiss velocity, complex focus orchestration after multi-swap, canvas)  
5. **Custom element / WAAPI** — gestures, pointer capture, cleanup-heavy browser APIs  
6. **Library** — human-approved only after CSS/WAAPI fail for a documented reason  

### When JS is justified (examples)

| Need | Prefer first | JS only if… |
| --- | --- | --- |
| Open/close panel | `<details>`, `popover`, CSS `:has()` | Complex nested focus trap the native control can’t do |
| Filters / sort / page | Form GET + server (or static CSS `:has()` demos) | Client-only typeahead over large sets with no server |
| Modal confirm | `<dialog>` + form, or `popover` | Focus restore after async destroy of invoker |
| Tabs | radio/`role=tab` patterns, links + server | Rare |
| Scroll reveal | CSS view timelines / accept static | Must support engines without scroll-driven CSS *and* motion is required |
| Toast after action | Server flash partial, `:target` fragment | Multi-toast queue with timers |
| Drag / momentum | — | Yes — pointer capture + velocity needs script |

### When JS is *not* justified

- Toggling a class a checkbox + `:has()` can toggle  
- Filtering a small static table (use radios + `:has()`, or server GET)  
- Scroll-fade “wow” that CSS can approximate or that Brand mode can skip under reduced motion  
- Re-implementing `<select>`, `<dialog>`, or form validation in script (style the native control instead)  
- Client state stores for filters the URL or server already owns  

### Script rules (when you must ship JS)

- Justify in a one-line comment or skill note: *what native path failed*  
- One behavior per module or custom element; keep units small  
- Clean up listeners in `disconnectedCallback` / `removeEventListener`  
- Prefer event delegation and `data-*` hooks  
- After HTMX swaps, re-bind idempotently only if needed  
- Never make JS the source of truth for business state the server already owns  
- Feature must degrade: without JS, core read path and primary actions still work when reasonable

## When the host project differs

If the host app already uses a forbidden tool, **do not churn the stack** in the name of this pack.

1. Match local conventions for files you touch
2. Still apply the craft rules (frequency, easing, duration, reduced motion)
3. Prefer the cheapest local tool (e.g. if Motion is already a dep, use it sparingly rather than adding a second kit)
