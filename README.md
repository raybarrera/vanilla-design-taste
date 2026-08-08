# Vanilla Design Taste

Agent skills for **UI craft and motion** on a **vanilla CSS + server-rendered HTML** stack.

Inspired by [Emil Kowalski](https://emilkowal.ski/)'s design-engineering teaching and the public skill pack [emilkowalski/skills](https://github.com/emilkowalski/skills). This is a deliberate rewrite for hypermedia apps — not a fork of his React-oriented recipes. See [ATTRIBUTION.md](./ATTRIBUTION.md).

## Why this exists

Emil's skills teach excellent taste: frequency-aware motion, strong easing, interruptibility, restraint. His pack also steers agents toward Motion, Base UI, Tailwind-adjacent tooling, and curated React libraries.

Many products want that **taste** without that **stack**:

- Vanilla CSS only
- Server-rendered HTML, forms, and progressive enhancement (for example HTMX)
- Minimal JavaScript; custom elements when needed
- No default path to npm animation kits

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
| [design-taste](./skills/design-taste/SKILL.md) | General UI polish, component feel, design-engineering review |
| [animate](./skills/animate/SKILL.md) | Build a specific animation or transition from scratch |
| [review-animations](./skills/review-animations/SKILL.md) | Strict review of motion in a diff or surface |
| [find-animation-opportunities](./skills/find-animation-opportunities/SKILL.md) | Hunt places that should (and should not) move |
| [improve-animations](./skills/improve-animations/SKILL.md) | Audit a codebase and write execution plans (read-only) |
| [animation-vocabulary](./skills/animation-vocabulary/SKILL.md) | Name an effect so prompts and reviews stay precise |
| [fluid-interfaces](./skills/fluid-interfaces/SKILL.md) | Gesture-driven UI, sheets, drag, momentum (CSS/WAAPI first) |
| [prototype](./skills/prototype/SKILL.md) | Explore multiple vanilla HTML/CSS variants behind a picker |

Shared doctrine (also vendored into each skill’s `references/`):

- [references/stack.md](./references/stack.md) — hard stack rules (wins over any recipe)
- [references/motion-tokens.md](./references/motion-tokens.md) — curves, durations, press feedback
- [ATTRIBUTION.md](./ATTRIBUTION.md) — credit and relationship to Emil's work

## Stack in one line

**HTML + vanilla CSS first. Hypermedia second. Tiny JS third. Motion libraries only with human approval.**

## What we intentionally omit

| Emil pack idea | Why omitted / replaced |
| --- | --- |
| `pick-ui-library` (Sonner, base-ui, zustand, cva, …) | Pushes React/npm defaults; contradicts this pack |
| Framer Motion / Motion as the spring default | Replaced with CSS + WAAPI + optional custom elements |
| Tailwind / CVA styling path | Vanilla CSS tokens only |
| JSX mount-flag patterns as primary entry | Prefer `@starting-style`, server HTML, class toggles |

## Contributing

Default branch is **`master`**. Open a **pull request** for every change — do not push commits straight to `master`.

## License

MIT — see [LICENSE](./LICENSE).  
Doctrine inspired by Emil Kowalski; original skill text in this repo is authored for vanilla/hypermedia stacks. Attribution details in [ATTRIBUTION.md](./ATTRIBUTION.md).
