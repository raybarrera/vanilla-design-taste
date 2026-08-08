# Vanilla Design Taste

Agent skills for **UI craft and motion** on a **vanilla CSS + server-rendered HTML** stack.

Inspired by [Emil Kowalski](https://emilkowal.ski/)'s design-engineering teaching and the public skill pack [emilkowalski/skills](https://github.com/emilkowalski/skills). This is a deliberate rewrite for hypermedia apps — not a fork of his React-oriented recipes. See [ATTRIBUTION.md](./ATTRIBUTION.md).

## Why this exists

Emil's skills teach excellent taste: frequency-aware motion, strong easing, interruptibility, restraint. His pack also steers agents toward Motion, Base UI, Tailwind-adjacent tooling, and curated React libraries.

Many products (including [Brighter](https://github.com/pangobit)-style apps) want that **taste** without that **stack**:

- Vanilla CSS only
- Templ / HTMX / forms / progressive enhancement
- Minimal JavaScript; custom elements when needed
- No default path to npm animation kits

## Install (global `~/.agents`)

From a clone of this repo:

```bash
./install.sh
```

That installs into `$AGENTS_HOME` or `~/.agents` by default:

```text
~/.agents/
  packs/vanilla-design-taste/     # skills, references, attribution
  skills/<name> → ../packs/vanilla-design-taste/skills/<name>
```

Symlinks keep skill-relative links to `references/` and `ATTRIBUTION.md` working. Re-run `./install.sh` after pulls to refresh.

| Flag | Meaning |
| --- | --- |
| `--dir PATH` | Custom agents root (same as `AGENTS_HOME`) |
| `--copy` | Copy skill trees instead of symlinking |
| `--force` | Replace skill names not already owned by this pack |
| `--uninstall` | Remove this pack and its skill entries only |
| `--dry-run` | Print actions without writing |

```bash
./install.sh --dry-run
./install.sh --dir ~/.agents
./install.sh --uninstall
```

### Other harness paths

For project-local or non-`.agents` hosts, copy or symlink `skills/<name>/` yourself:

```text
# Project-local agent-resources style
.agents/skills/<skill-name>/SKILL.md

# Grok
.grok/skills/<skill-name>/SKILL.md
```

If you only copy skill folders, also place `references/` so `../../references/` from a skill resolves (same layout as the pack install).

## Contributing

Default branch is **`master`**. Open a **pull request** for every change — do not push commits straight to `master`.
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

Shared doctrine:

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

## License

MIT — see [LICENSE](./LICENSE).  
Doctrine inspired by Emil Kowalski; original skill text in this repo is authored for vanilla/hypermedia stacks. Attribution details in [ATTRIBUTION.md](./ATTRIBUTION.md).
