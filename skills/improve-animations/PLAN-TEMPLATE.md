# Plan template

Write one file per finding: `plans/NNN-short-slug.md`.

```markdown
# NNN — <short title>

- **Severity:** HIGH | MEDIUM | LOW
- **Category:** <from AUDIT.md>
- **Commit:** <short sha>
- **Stack constraint:** vanilla CSS / WAAPI / custom element only (or: host already uses X)

## Problem

<what feels wrong, for whom, how often>

## Evidence

- `path/to/file.ext:line` — excerpt

```css
/* current */
```

## Goal

<observable feel after the change>

## Exact target values

- Easing: `cubic-bezier(...)` or `var(--ease-out)` (define if missing)
- Duration: `…ms`
- Properties: `transform`, `opacity`, …
- Reduced motion: <behavior>

## Steps

1. …
2. …
3. …

## Out of scope

- …

## Verification

- [ ] Visual check on <surface>
- [ ] Slow-mo / Animations panel
- [ ] `prefers-reduced-motion`
- [ ] Touch + mouse if hover/press involved
- [ ] No new dependencies

## Feel-check

<what “right” feels like in one sentence>
```
