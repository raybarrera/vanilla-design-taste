# Vanilla Design Taste

Agent skills for **frontend design taste**, **admin UI craft**, and **motion** on a **vanilla CSS + server-rendered HTML** stack.

Inspired by [Emil Kowalski](https://emilkowal.ski/)'s design-engineering teaching and the public skill pack [emilkowalski/skills](https://github.com/emilkowalski/skills), plus durable ideas from widely used frontend and product/admin design skills — rewritten for hypermedia apps, not forked. See [ATTRIBUTION.md](./ATTRIBUTION.md).

## Why this exists

Popular design skills teach useful taste: distinctive direction, anti-slop defaults, dense product hierarchy, frequency-aware motion. Many of them also steer agents toward React, Tailwind, Motion, and npm UI kits.

Many products want that **taste** without that **stack**:

- Vanilla CSS only
- Server-rendered HTML, forms, and progressive enhancement (for example HTMX)
- **No JavaScript by default** — HTML/CSS/hypermedia first; script only when native affordances fall short
- No default path to npm animation or component kits

This pack is that adaptation: general frontend craft, admin/data UI patterns, and motion skills that share one stack doctrine.

## Install

Installs into the **cross-client user skills path** documented by [Agent Skills](https://agentskills.io/client-implementation/adding-skills-support):

```text
~/.agents/skills/<skill-name>/SKILL.md
```

### One-liner (no clone)

```bash
curl -fsSL https://raw.githubusercontent.com/raybarrera/vanilla-design-taste/master/install.sh | bash
```

With flags (note `bash -s --`):

```bash
curl -fsSL https://raw.githubusercontent.com/raybarrera/vanilla-design-taste/master/install.sh | bash -s -- --force
```

`wget` equivalent:

```bash
wget -qO- https://raw.githubusercontent.com/raybarrera/vanilla-design-taste/master/install.sh | bash
```

The script shallow-clones this repo (ref `master`, or `$VDT_REF` / `--ref`) into a temp dir, copies each skill into `~/.agents/skills/`, then removes the clone.

### From a local clone

```bash
./install.sh
```

Each skill is a **self-contained** directory (agentskills.io layout): `SKILL.md` plus optional `references/`. Re-run the same command to refresh.

| Flag | Meaning |
| --- | --- |
| `--dir PATH` | Skills directory (default: `$AGENTS_SKILLS_DIR` or `~/.agents/skills`) |
| `--ref REF` | Git ref for remote fetch (default: `master` or `$VDT_REF`) |
| `--force` | Replace skill names not already managed by this pack |
| `--uninstall` | Remove only skills this pack installed |
| `--dry-run` | Print actions without writing |

```bash
./install.sh --dry-run
./install.sh --uninstall
```

### Other harness locations

If your agent only scans a vendor path, copy or symlink the same skill directories there (or point the harness at `~/.agents/skills`):

```text
~/.claude/skills/<skill-name>/
~/.grok/skills/<skill-name>/
.agents/skills/<skill-name>/          # project-local
```

## Skills

| Skill | Use when |
| --- | --- |
| [design-taste](./skills/design-taste/SKILL.md) | General UI polish, component feel, craft review; routes to specialists |
| [frontend-design](./skills/frontend-design/SKILL.md) | Distinctive visual design for product **and** marketing; anti-slop; type, hierarchy, copy |
| [admin-ui](./skills/admin-ui/SKILL.md) | Dense admin panels, dashboards, tables, filters, settings, internal tools |
| [animate](./skills/animate/SKILL.md) | Build a specific animation or transition from scratch |
| [review-animations](./skills/review-animations/SKILL.md) | Strict review of motion in a diff or surface |
| [find-animation-opportunities](./skills/find-animation-opportunities/SKILL.md) | Hunt places that should (and should not) move |
| [improve-animations](./skills/improve-animations/SKILL.md) | Audit a codebase and write execution plans (read-only) |
| [animation-vocabulary](./skills/animation-vocabulary/SKILL.md) | Name an effect so prompts and reviews stay precise |
| [fluid-interfaces](./skills/fluid-interfaces/SKILL.md) | Gesture-driven UI, sheets, drag, momentum (CSS/WAAPI first) |
| [prototype](./skills/prototype/SKILL.md) | Explore multiple vanilla HTML/CSS variants behind a picker |

### Which skill?

| Need | Skill |
| --- | --- |
| Distinctive page/component look, anti-slop, type, marketing or general product chrome | `frontend-design` |
| Admin panel, CRM, dashboard, dense table, settings IA, internal tool | `admin-ui` |
| Build, review, or audit a specific animation | motion skills (`animate`, `review-animations`, …) |
| Component press/feel + general craft without a full redesign | `design-taste` |

Shared doctrine (also vendored into each skill’s `references/`):

- [references/stack.md](./references/stack.md) — hard stack rules (wins over any recipe)
- [references/motion-tokens.md](./references/motion-tokens.md) — curves, durations, press feedback
- [references/visual-craft.md](./references/visual-craft.md) — hierarchy, density, anti-slop, brand vs product modes
- [references/admin-patterns.md](./references/admin-patterns.md) — shells, tables, filters, data states
- [ATTRIBUTION.md](./ATTRIBUTION.md) — credit and relationship to source inspirations

## Stack in one line

**HTML + vanilla CSS first. Hypermedia second. JS only when native affordances fall short. Motion libraries only with human approval.**

## What we intentionally omit

| Common skill-pack idea | Why omitted / replaced |
| --- | --- |
| Emil `pick-ui-library` (Sonner, base-ui, zustand, cva, …) | Pushes React/npm defaults; contradicts this pack |
| Framer Motion / Motion as the spring default | Replaced with CSS + WAAPI + optional custom elements |
| Tailwind / CVA styling path | Vanilla CSS tokens only |
| JSX mount-flag patterns as primary entry | Prefer `@starting-style`, server HTML, class toggles |
| Shipping third-party skills verbatim | We rewrite popular FE/admin craft for hypermedia; see ATTRIBUTION |

## Contributing

Default branch is **`master`**. Open a **pull request** for every change — do not push commits straight to `master`.

## License

MIT — see [LICENSE](./LICENSE).  
Doctrine inspired by Emil Kowalski and other public design skills; original skill text in this repo is authored for vanilla/hypermedia stacks. Attribution details in [ATTRIBUTION.md](./ATTRIBUTION.md).
