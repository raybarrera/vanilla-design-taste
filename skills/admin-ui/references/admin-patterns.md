# Admin UI Patterns

Dense, task-first patterns for dashboards, CRMs, internal tools, and settings on **semantic HTML + vanilla CSS + hypermedia**. Stack law: [stack.md](./stack.md). Visual floor: [visual-craft.md](./visual-craft.md). Motion: [motion-tokens.md](./motion-tokens.md).

**Not for:** marketing pages, campaign landing, brand storytelling. Use the `frontend-design` skill (Brand mode) for those.

## Operating principles

1. **The verb is the UI.** Approve, find, filter, edit, export — design for the action, not a card collage.
2. **Scan first.** Operators skim; hierarchy and alignment beat decoration.
3. **Same chrome everywhere.** Shell, table density, button sizes, and filter placement should feel like one product.
4. **High frequency → still.** Nav toggles, row selection, pagination: no animation theater (see frequency gate in motion-tokens).
5. **Server owns business state.** Filters, sort, page, selection that must survive refresh: URL or form fields, not a client store by default.
6. **Theme is the host’s.** Consume project tokens; do not invent a second admin palette ([visual-craft.md](./visual-craft.md) § theme consistency + light/dark check).

## Visual hierarchy (admin)

Admin hierarchy is **scan order for a job**, not “make the header pretty.”

### Page levels (top → bottom)

| Layer | Role | Typical treatment |
| --- | --- | --- |
| 1. Task | What am I doing? | `h1` page title — one per view |
| 2. Orientation | Where am I? | Breadcrumb / section nav — muted, smaller |
| 3. Primary action | What can I do now? | One solid primary button |
| 4. Attention | What needs me? | Quiet strip or filter chip — not a second hero |
| 5. Controls | How do I narrow? | Filter bar — secondary weight |
| 6. Work surface | Where do I act? | **Table or form** — most pixels live here |
| 7. Meta | Context only | Timestamps, ids, counts — muted, tabular where numeric |

If layers 1–5 compete with layer 6 for attention, demote 1–5 (smaller type, less chrome), not the work surface.

### Within a row or record

1. **Identity** first (name, job id + short route) — medium/semibold primary  
2. **State** second (status text + color) — scannable, not huge  
3. **Measure** third (money, %, ETA) — tabular, end-aligned  
4. **Meta** last (last active, secondary email) — muted, smaller  
5. **Actions** trailing — consistent column; ghost/text buttons  

### Density of hierarchy signals

Prefer **weight + color/opacity** over size jumps. A 14px table can hold three tiers without 20px titles inside every cell.

### Admin hierarchy failures

| Failure | Fix |
| --- | --- |
| Six equal KPI cards above a tiny table | Quiet metric strip; enlarge the table |
| Every label bold | Labels muted; values stronger |
| Page title, section title, and card titles all same size | Step the type scale; one clear `h1` |
| Status as a huge pill that steals the row | Compact status; identity stays lead |
| Inset “selected” lip on nav/rows | Background or full-height edge — ban inset box-shadow lips ([visual-craft.md](./visual-craft.md)) |

## Rows vs cards vs other surfaces

Choose the **container** from the job, not from fashion.

| Pattern | Use when | Avoid when |
| --- | --- | --- |
| **Data table (rows)** | Many homogeneous records; compare columns; sort/filter/bulk; dense scanning | Few items with long narrative; highly heterogeneous fields per item |
| **Definition list / key-value** | Single record detail; settings; metadata sidebar | Long browsable inventories (use table or list) |
| **Stacked list rows** (full-width rows, not `<table>`) | Mobile-first feeds; 2–4 fields per item; optional swipe actions | Wide desktop compare-across-columns jobs |
| **Cards in a grid** | Few objects (≤ ~12) with distinct media or multi-line content; picker galleries | Default for “dashboard”; bulk triage; spreadsheet-shaped data |
| **Metric strip** | 3–6 summary measures above a work surface | Replacing the work surface; icon-stat marketing cards |
| **Kanban / columns** | Explicit workflow stages operators move between | Flat filterable indexes better as a table |
| **Timeline** | Ordered events for one entity | Primary inventory of all entities |

### Defaults

- **Indexes / queues / CRMs:** table first.  
- **Record detail:** key-value + sections; optional small related table.  
- **Dashboards:** metric strip **plus** the primary queue (table or list) — not a wall of cards alone.  
- **Cards in admin** only when each object needs a multi-line “poster” (e.g. template gallery). If you can put it in columns, prefer a table.

### Card slop in admin

Refuse: equal card grids of stats, gradient tiles, large icons per metric, “feature cards” for navigation that should be a sidebar link.

## Alignment (admin)

See also [visual-craft.md](./visual-craft.md) § Alignment. Admin-specific:

| Context | Rule |
| --- | --- |
| Table numbers | `text-align: end` + `tabular-nums` |
| Table text | `text-align: start` |
| Checkbox column | Fixed narrow width; centered control |
| Actions column | End-aligned; same control order every row |
| Filters | One alignment system: all labels above **or** all inline — don’t mix on one bar |
| Forms | Label column width shared; controls share start edge |
| Page header | Title block start, actions end, vertically centered as a group |
| Sticky header | Column alignment must match body when scrolled |

**Grid beat:** if the filter bar, table, and footer don’t share a content start/end edge, fix the layout shell before polishing colors.

## Field types and presentation

Present data by **type and role**, not all as the same 14px string.

| Kind | Presentation | CSS / markup notes |
| --- | --- | --- |
| **Page / section title** | Strong, larger, tight tracking | One `h1` per view; sections `h2` |
| **Column / form label** | Small, medium weight, muted | Never rely on placeholder alone |
| **Person / object name** | Primary weight; link if navigable | Second line for email/meta muted |
| **Short id / code** (SKU, job no.) | Mono or tabular; often medium weight | Keep copyable; don’t oversize |
| **GUID / UUID** | Mono, muted, smaller; truncate middle or show last segment + full `title` | Never display as a hero metric; allow copy |
| **Integer count** | Tabular nums; end-align in columns | No unnecessary decimals |
| **Float / decimal** | Tabular; fixed fraction digits per column (e.g. always 2) | Align decimal columns consistently |
| **Money** | Tabular; end-align; currency symbol consistent (column header or per cell, not mixed) | Same fraction digits in a column |
| **Percent** | Tabular; end-align; include `%`; optional bar only if it helps compare | Don’t animate bars on load |
| **Date / time** | Consistent format per product; relative only if unambiguous (`title` = absolute) | Don’t mix `01/02` locales in one table |
| **Email / URL** | Secondary line or mono small; link with clear text | Break long strings (`overflow-wrap`) |
| **Enum / status** | Short label + color + optional icon | Never color alone |
| **Boolean** | Explicit words or labeled switch (“Active”), not bare ✓/✗ only | |
| **Empty / null** | Em dash or “—” muted, or “Not set” — one convention | Don’t leave blank cells that look broken |
| **Long text** | Clamp with expand, or detail page — not huge table cells | `title` or detail link for full text |

### Form controls by type

| Input | Notes |
| --- | --- |
| Text | Visible label; hint under; error next to field |
| Number | `inputmode` / step as needed; right-align value in dense tables when displayed read-only |
| Money | Explicit currency; avoid float surprises in copy (server formats) |
| Select / enum | Native or host partial; don’t invent custom without keyboard |
| Date | Prefer native or host date control; show format expectation in hint |
| GUID search | Mono input; paste-friendly; don’t uppercase unless the system requires |

### Type scale reminder for data

```text
label / meta:  12–12.5px, muted, weight 500
body / name:   13–14px, primary, weight 500–600
metric value:  22–28px, semibold, tabular
guid / code:   12px, mono, muted
```

Match host tokens when they exist.

## App shell

```html
<body class="admin">
  <a class="skip-link" href="#main">Skip to content</a>
  <div class="admin-shell">
    <aside class="admin-nav" aria-label="Primary">…</aside>
    <div class="admin-main">
      <header class="admin-topbar">…</header>
      <main id="main" class="admin-content">…</main>
    </div>
  </div>
</body>
```

| Rule | Practice |
| --- | --- |
| Sidebar surface | Same background as content; subtle border or hairline — not a loud second theme |
| Width says priority | ~220–280px nav “serves content”; much wider starts competing with the work |
| Top bar | Breadcrumb / page title / primary action; keep secondary actions quieter |
| Content width | Tables and lists often need full width; forms/settings may use a readable measure |
| Mobile | Collapse nav to a disclosure or off-canvas panel; do not hide critical actions only in the sidebar |

```css
.admin-shell {
  display: grid;
  grid-template-columns: var(--admin-nav-width, 15rem) 1fr;
  min-height: 100dvh;
}

.admin-nav {
  background: var(--surface-page);
  border-inline-end: 1px solid var(--border-subtle);
}

.admin-content {
  padding: var(--space-section, 1.5rem);
}
```

## Page header (list / detail)

One row that answers: **where am I**, **what can I do now**.

```html
<header class="page-header">
  <div class="page-header__text">
    <nav class="breadcrumb" aria-label="Breadcrumb">…</nav>
    <h1 class="page-title">Orders</h1>
    <p class="page-desc">Open and fulfilled orders for this store.</p>
  </div>
  <div class="page-header__actions">
    <a class="button button--secondary" href="…">Export</a>
    <a class="button button--primary" href="…">Create order</a>
  </div>
</header>
```

- One primary action max in the header (or one clear default).
- Secondary actions are outline/ghost or a “More” menu — not three equal solid buttons.

## Metric strip (KPIs)

Avoid the generic three equal gradient cards with big icons.

```html
<section class="metric-strip" aria-label="Summary">
  <div class="metric">
    <p class="metric__label">Revenue</p>
    <p class="metric__value">$48,200</p>
    <p class="metric__delta metric__delta--up">↑ 12% vs last week</p>
  </div>
  <!-- more metrics -->
</section>
```

```css
.metric-strip {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(10rem, 1fr));
  gap: var(--space-component, 1rem);
}

.metric__label {
  font-size: 0.75rem;
  font-weight: 500;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  color: var(--content-muted);
}

.metric__value {
  font-size: 1.75rem;
  font-weight: 600;
  font-variant-numeric: tabular-nums;
  line-height: 1.2;
}

.metric__delta {
  font-size: 0.8125rem;
  font-weight: 500;
}
```

- Status in the delta uses color **and** text/arrow.
- Prefer a quiet strip over icon-heavy “stat cards” unless the product language truly needs icons.

## Filter bar + toolbar

Filters are part of the job, not chrome decoration.

```html
<form
  class="filter-bar"
  method="get"
  action="/admin/orders"
  hx-get="/admin/orders"
  hx-target="#results"
  hx-push-url="true"
  hx-trigger="change delay:200ms, submit"
>
  <label>
    <span class="visually-hidden">Search</span>
    <input type="search" name="q" value="…" placeholder="Search orders" />
  </label>
  <label>
    Status
    <select name="status">…</select>
  </label>
  <label>
    From
    <input type="date" name="from" />
  </label>
  <button type="submit" class="button button--secondary">Apply</button>
</form>
```

| Rule | Practice |
| --- | --- |
| State | Query params (or form GET) so links and back-button work |
| Layout | Single horizontal bar that wraps; labels visible or properly `aria-label`ed |
| Apply | Live filter via hypermedia is fine; always keep a no-JS submit path when using progressive enhancement |
| Clear | “Clear filters” when any filter is active |
| Bulk | Selection actions appear only when rows are selected (partial swap of toolbar) |

## Data tables

```html
<div class="table-wrap" role="region" aria-label="Orders" tabindex="0">
  <table class="data-table">
    <thead>
      <tr>
        <th scope="col">
          <label><input type="checkbox" name="select_all" /> <span class="visually-hidden">Select all</span></label>
        </th>
        <th scope="col"><a href="?sort=id">Order</a></th>
        <th scope="col"><a href="?sort=customer">Customer</a></th>
        <th scope="col" class="num"><a href="?sort=total">Total</a></th>
        <th scope="col">Status</th>
        <th scope="col"><span class="visually-hidden">Actions</span></th>
      </tr>
    </thead>
    <tbody>…</tbody>
  </table>
</div>
```

| Rule | Practice |
| --- | --- |
| Semantics | Real `<table>` for tabular data — not a grid of divs pretending to be rows |
| Sticky header | `position: sticky; top: 0` on `th` when lists are long |
| Numbers | Right-align + `tabular-nums` |
| Row density | Tool-tight padding (8–12px); consistent across admin |
| Row click | Prefer an explicit “Open” control or link in the row; if whole-row click exists, keep a real link for middle-click/accessibility |
| Status | Pill or plain text with icon; never color-only |
| Actions | End column: text buttons or a single overflow control — not three icon-only mystery buttons without labels |
| Overflow | Horizontal scroll on the wrap region; do not crush columns into illegible ellipsis by default |
| Empty columns | Don’t invent placeholder columns to “fill the layout” |

```css
.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.875rem;
}

.data-table th,
.data-table td {
  padding: 0.5rem 0.75rem;
  border-bottom: 1px solid var(--border-subtle);
  text-align: start;
  vertical-align: middle;
}

.data-table th {
  position: sticky;
  top: 0;
  background: var(--surface-page);
  font-weight: 500;
  color: var(--content-secondary);
  z-index: 1;
}

.data-table .num {
  text-align: end;
  font-variant-numeric: tabular-nums;
}

.data-table tbody tr:hover {
  background: var(--surface-raised);
}

@media (hover: hover) and (pointer: fine) {
  .data-table tbody tr:hover {
    background: var(--surface-raised);
  }
}
```

## Pagination

- Prefer server pagination links (`?page=`) over infinite scroll for admin (jump, share, back).
- Show range: “Showing 1–50 of 1,204”.
- Disable prev/next at ends; keep markup stable for HTMX swaps.

## Detail + edit layouts

| Pattern | When |
| --- | --- |
| Two-column: main form + side meta | Order/customer detail with timeline or attributes |
| Single readable column (~32–40rem) | Settings sections, long forms |
| Full-bleed table only | Pure index pages |

- Destructive actions live away from the primary save path (footer danger zone or confirm dialog).
- Use `<section>` + heading per settings group; one form or clear per-section save matching host conventions.

## Settings

```html
<form class="settings" method="post" action="…">
  <section class="settings-section">
    <header>
      <h2>Notifications</h2>
      <p class="section-desc">Email and in-app alerts for this workspace.</p>
    </header>
    <div class="field">
      <label for="email-alerts">Email alerts</label>
      <select id="email-alerts" name="email_alerts">…</select>
      <p class="field-hint">Sent for failures and approvals only.</p>
    </div>
  </section>
  <div class="form-actions">
    <button type="submit" class="button button--primary">Save changes</button>
  </div>
</form>
```

- Labels always associated (`for` / `id` or wrapping).
- Hints under fields, errors next to fields + summary if many.
- Do not use placeholder as the only label.

## Bulk actions and destructive flows

```html
<div class="bulk-bar" hidden data-bulk-bar>
  <p><span data-bulk-count>0</span> selected</p>
  <button type="submit" form="bulk-form" name="action" value="archive" class="button button--secondary">Archive</button>
  <button
    type="submit"
    form="bulk-form"
    name="action"
    value="delete"
    class="button button--danger"
    formaction="/admin/orders/bulk-delete"
  >Delete…</button>
</div>
```

- Confirm irreversible bulk deletes with a real step: native `<dialog>`, confirm page, or typed confirmation for high-risk.
- Prefer POST + server validation; CSRF tokens as the host requires.
- Success: flash/toast partial or inline banner — quiet, not confetti.

## Loading / empty / error

### Loading

Prefer skeleton rows that match table geometry over a centered spinner-only page.

```html
<tbody aria-busy="true">
  <tr class="skeleton-row" aria-hidden="true"><td colspan="6"></td></tr>
  …
</tbody>
```

### Empty

```html
<div class="empty-state" role="status">
  <h2>No orders yet</h2>
  <p>Create an order or adjust filters to see results.</p>
  <a class="button button--primary" href="…">Create order</a>
</div>
```

### Error

```html
<div class="error-state" role="alert">
  <h2>Couldn’t load orders</h2>
  <p>The server returned an error. Try again. If it keeps happening, contact support.</p>
  <a class="button button--secondary" href="…">Retry</a>
</div>
```

## Zero-JS and low-JS patterns (static or progressive)

Prefer these before writing a filter controller or table framework:

| Affordance | Native / CSS approach |
| --- | --- |
| Status / cohort filter (demo or small lists) | Radios or checkboxes + `:has()` to show/hide `tr[data-status]` |
| Shareable filters (production) | `method="get"` form; server returns filtered table partial |
| Bulk bar visibility | `.toolbar:has(.row-check:checked) .bulk-bar { display: flex }` |
| Confirm remove | `<dialog>` + form, or `popover` + `popovertarget` (no `showModal` script) |
| Mobile nav | `<details>` / `<summary>`, or checkbox + `:has()` drawer |
| Empty-state demo toggle | Checkbox + label + `:has()` to swap panels |
| Flash / toast | Server-rendered banner, or `:target` fragment for static demos |
| Row actions | Always in DOM; reveal with `tr:focus-within` / hover (fine pointer) — not JS `mouseenter` |

**Select-all**, live search over large sets, and drag-reorder usually need script or server help — do not fake them poorly in JS when a GET form + server is the real product path.

## HTMX / hypermedia notes

- Target the smallest region (`#results`, toolbar bulk bar) so the shell does not flash.
- Preserve focus management: after swap, move focus when the user initiated a dialog or major view change.
- Re-init only if needed (`htmx:afterSettle`); prefer declarative behavior — **no JS** when the partial is self-contained.
- Partial HTML returns full accessible markup for the swapped fragment (include table headers if replacing whole table).

## Motion in admin

| Surface | Motion |
| --- | --- |
| Pagination, sort, filter apply | None or imperceptible opacity |
| Row select, checkbox | None |
| Modal confirm | Short enter per motion-tokens |
| Toast after save | Occasional; interruptible transitions |
| Sidebar open (mobile) | Short panel; reduced-motion: opacity only |

Press feedback on primary buttons still applies (`scale` on `:active`) — that is feedback, not decoration.

## Review snags (admin-specific)

| Smell | Fix |
| --- | --- |
| Marketing card grid as a “dashboard” | Metric strip + table/list for the real job |
| Div soup “tables” | Real `<table>` or a host data-grid partial |
| Three equal primary buttons | One primary; demote the rest |
| Sidebar a different colorful theme | Same surface + border |
| Filters only in client JS state | URL/form GET |
| Icon-only actions without names | Visible text or `aria-label` + title carefully |
| Empty page is blank white | Empty state + next action |
| Every KPI a rainbow gradient card | Quiet strip; accent only on status |

## Operator polish (“wow” as competence)

Admin delight is **feeling fast, clear, and trustworthy** — not landing-page theater. Add these after structure works.

### Attention and scanning

- **Needs-attention strip** above the table when count > 0: plain language (“14 learners need a nudge”), link that applies the filter, not a second dashboard  
- **Row emphasis:** soft tint and/or **full-height** `border-inline-start` for `at-risk` / failed / overdue — still show status text. **Never** `box-shadow: inset 2px 0 0` lips  
- **Primary column weight:** name/id medium-strong; meta muted on a second line  
- **Action reveal:** row actions visible on focus-within / hover (fine pointer); always available to keyboard (never `display:none` only)

### Toolchrome

- **Command-style filter:** search field feels like a tool (inset, `/` shortcut hint optional, large hit area)  
- **Sticky page header + sticky table header** so filters and columns stay oriented while scrolling  
- **Bulk bar** occupies stable space or slides without shifting the whole page jumpy amounts  
- **Keyboard:** `Esc` closes dialogs; focus returns to invoker; skip link works  

### Feedback

- **Toast / inline flash** after nudge, export, save — quiet, interruptible, not confetti  
- **Optimistic label** on buttons while “pending” only if the host can reconcile; otherwise disable + spinner text  
- **Empty state** with domain-specific line art (CSS/SVG gradebook, inbox) — still one CTA  

### Material (quiet)

- Hairline borders, inset inputs, same-hue surfaces  
- Optional **dark rail / light canvas** only if APCA Lc holds for text/chrome in both polarities and both stay in one hue family  
- Metric values use `tabular-nums` and a clear unit; avoid icon-stat cards  

### Do not

- Hero gradients, glassmorphism stacks, 3D product spins in the admin shell  
- Stagger-animate every table row on load  
- Confetti, celebration for routine saves  
- Inset box-shadow “lips” on nav or rows  
- Parallel color theme that ignores host tokens  
- Card grids as the default inventory pattern  

## Checklist

- [ ] Mode is admin/product-dense, not Brand
- [ ] Task verb and operator persona stated
- [ ] Density chosen and held (tool-tight default for tables)
- [ ] Visual hierarchy: work surface wins; labels demoted vs values
- [ ] Container choice justified (table vs cards vs key-value)
- [ ] Alignment: numbers end, text start, actions column consistent
- [ ] Field types presented correctly (tabular money/%, mono GUID, etc.)
- [ ] Host theme tokens used; light/dark legibility checked if both modes exist
- [ ] No inset lip shadows for selection/emphasis
- [ ] Shell: nav + main + clear primary action
- [ ] Tabular data in a real table when comparing records
- [ ] Filters shareable via URL/form
- [ ] Loading, empty, error present
- [ ] Destructive paths confirmed
- [ ] High-frequency chrome not animated
- [ ] Operator polish: attention strip / row emphasis / feedback where relevant
- [ ] Stack rules respected (no surprise React/Tailwind deps)
