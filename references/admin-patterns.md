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

Prefer **weight + color/opacity** over size jumps. Table **body** stays at a readable size (see § Type size floors) — do not achieve hierarchy by crushing data to ~11–12px.

### Multi-panel screens (required decision)

When a view has **more than one table or pane**, name the **primary work surface** out loud before layout:

| Role | Treatment |
| --- | --- |
| **Primary** | Most vertical space; strongest section title; first/largest in the main column |
| **Secondary** | Smaller chrome, tighter padding, quieter headings; may sit in a side column or above the primary in a compact band |
| **Meta / orientation** | Counts, selected id, “on this account” — thin strip, not equal posters |

**Ban:** three or more peer “product cards” of equal weight above a squeezed table (“debug dashboard”).

**Rhythm:** related secondary panes sit **closer** to each other; leave real air before the primary table so it reads as the next major region.

### Admin hierarchy failures

| Failure | Fix |
| --- | --- |
| Six equal KPI cards above a tiny table | Quiet metric strip; enlarge the table |
| Five equal stat posters (Users / Selected / Counts…) | One thin meta row; smaller type; not a second hero |
| Three peer cards above the real queue | One primary work surface; demote the rest |
| Every label bold | Labels muted; values stronger |
| Page title, section title, and card titles all same size | Step the type scale; one clear `h1` |
| Status as a huge pill that steals the row | Compact status; identity stays lead |
| All strings same weight (ids, prose, numbers) | Field-type presentation (below) |
| Fingernail lip on nav/rows (curved rail ends) | Background and/or **straight** stripe — ban the look ([visual-craft.md](./visual-craft.md)) |
| Data at ~11–12px so more columns fit | Raise body to ≥13–14px; fewer columns or horizontal scroll |

## Debug & internal tools

Genre: QA consoles, profile debuggers, radar inspectors, ops tools. Same admin rules, **stricter hierarchy**.

### Default flow

1. **Load identity** — account/user id field (mono) + **one** primary action (`Load`)  
2. **Select entity** — compact list (users, jobs) with clear selected state  
3. **Primary evidence table** — majority of the viewport (diary, events, attempts)  
4. **Secondary context** — topic marks, concept progress, related 0–3 row panes  

Lede: one line of **verb** + one constraint (“names omitted”). Long explanation → docs, not the page hero.

### Loader pattern

```html
<label for="account-id">Account id</label>
<input id="account-id" class="input-mono" name="account_id" spellcheck="false" />
<button type="submit" class="button button--primary">Load</button>
```

- One primary control for the load path; demote “User management” / settings to ghost or nav.  
- Full GUID in the field is fine; don’t also hero the same id in five metrics.

### Metric / summary strip (orientation only)

| Do | Do not |
| --- | --- |
| Single quiet row of counts/labels | Five equal stat tiles competing with the table |
| Small uppercase labels + modest tabular values | 28px marketing metrics on a debug page |
| Meta that answers “what did I load?” | A second dashboard |

If the strip disappeared, the operator should still complete the verb using the primary table.

### Named anti-patterns (avoid)

| Name | What it looks like | Fix |
| --- | --- | --- |
| **Debug dashboard** | Stats + cards everywhere; evidence table starved | Primary table wins the viewport |
| **Every subsection is a product card** | Badge counts, equal frames, poster padding | Tight panes or plain tables |
| **All strings same weight** | GUID = prose = score | Field-type table |
| **Accent spray** | Purple primary + purple chrome + purple chips | One accent for primary actions |
| **Fingernail rail** | Curved side lip on selected/failure rows | Tint ± straight stripe |
| **Microtype density** | 11–12px table body on a large display | ≥13–14px body; accept scroll or fewer columns |

### Review examples (bad → good)

| Before | After | Why |
| --- | --- | --- |
| Equal metric posters over diary | Thin meta strip; diary is largest block | Work surface must win |
| Users + topic + concept as peer cards above diary | Diary primary; others secondary/compact | Multi-panel hierarchy |
| Topic sentence full-width in a “table” cell | Clamp / max-width; full text via expand or `title` | Preserve column scan |
| Selected user as dim gray pill | Selected surface + weight (not disabled look) | Selection ≠ disabled |
| Incorrect rows with curved accent lip | Soft tint + square-end stripe | Fingernail ban |
| Table body `0.72rem` (~11.5px) | `0.875rem` (14px) or host body token | Legibility over packing |

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
- **Debug multi-pane:** one primary evidence table; side lists and 0–3 row context panes stay compact (not peer product cards).  
- **Cards in admin** only when each object needs a multi-line “poster” (e.g. template gallery). If you can put it in columns, prefer a table.  
- **Small result sets (0–3 rows):** tight table or key-value — not a marketing card with a large count badge.

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

### Type size floors (legibility over packing)

**Compact is not the same as microscopic.** On large displays, admin/debug tables often resolve to ~11–12px because agents set `0.7–0.75rem` on a 16px root. That fails APCA usefulness and operator fatigue even when the theme is “dense.”

| Role | Minimum (CSS px, reference) | Notes |
| --- | --- | --- |
| **Table / list body** (names, primary cells) | **14px** preferred; **13px** absolute floor | Prefer `0.875rem` if root is 16px; do not use 0.72rem body |
| **Form control text** | **14px** | Match body; inputs smaller than body feel broken |
| **Column headers / field labels** | **12px** floor | Muted, weight 500–600, tracked; not tinier than 12 |
| **Meta / timestamps / secondary** | **12px** floor | Muted; never smaller than headers without reason |
| **GUID / mono code in tables** | **12px** floor | Mono; muted; truncate + `title` — still ≥12px |
| **Status chips** | **12px** label | Compact padding; chip text not larger than body identity |
| **Quiet metric values** (debug meta strip) | **16–18px** | Not 28px posters; not 11px either |
| **Page `h1`** | **20–24px** | One only |

**Rules:**

1. Host type tokens win when they already set a readable admin scale — **do not undercut them** for “more columns.”  
2. If columns don’t fit: **horizontal scroll**, hide nonessential columns, or progressive disclosure — **not** sub-13px body.  
3. `html { font-size: 16px }` (or browser default) unless the host already defines rem; don’t shrink the root to fake density.  
4. Check **computed** px in devtools on a large viewport; design intent is the rendered size, not the rem string alone.  
5. Dense **padding** (8–12px) is fine; dense **type** below the floor is not.

### Type scale reminder for data

```text
label / meta:     12px, muted, weight 500–600
body / name:      13–14px, primary, weight 500–600
table body:       14px preferred (13px floor)
guid / code:      12px mono muted (not < 12)
quiet metric:     16–18px tabular
marketing metric: avoid on debug/admin queues
page title:       20–24px
```

Match host tokens when they exist — only if they meet these floors.

### Debug-oriented field notes

| Kind | Extra |
| --- | --- |
| **Account GUID (loader)** | Full value in mono input; paste-friendly; not repeated as five hero stats |
| **Truncated entity id** | Mono + muted + `title` = full; selected list row = background + weight, not a disabled pill |
| **ISO timestamp** | Tabular, muted, smaller than body; optional `title` with full Zulu if you show local |
| **Score / confidence float** | Fixed fraction digits (e.g. 2); end-align; empty = `—` |
| **Long topic / prompt prose** | Max-width + line clamp in tables; full text on detail or expand |
| **Outcome chips** | Compact; never larger/heavier than the primary identity column |

### Emphasis on failure rows

- Soft row tint ± **straight** stripe (square ends).  
- Status text remains (“incorrect”), not color alone.  
- If the job is “why did the latest attempt fail,” prefer **newest failure** emphasis or an “incorrect only” filter over tinting half the table equally.

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
- **Row emphasis:** soft tint and/or a **straight** full-height stripe (`::before`, square ends) for `at-risk` / failed / overdue — still show status text. **Never** fingernail lips (curved rail ends from inset shadow or `border-inline-start` on rounded boxes)  
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
- Fingernail lips (curved side rails) on nav, cards, or rows — any property that causes them  
- Parallel color theme that ignores host tokens  
- Card grids as the default inventory pattern  

## Checklist

- [ ] Mode is admin/product-dense, not Brand (or debug/internal with stricter hierarchy)
- [ ] Task verb and operator persona stated
- [ ] Density chosen and held — **padding** dense OK; **type** meets size floors
- [ ] Multi-panel: primary work surface named; peers demoted
- [ ] Metrics are orientation only (no equal stat posters over the queue)
- [ ] Visual hierarchy: work surface wins; labels demoted vs values
- [ ] Container choice justified (table vs cards vs key-value)
- [ ] Alignment: numbers end, text start, actions column consistent
- [ ] Field types presented correctly (tabular money/%, mono GUID, timestamps, etc.)
- [ ] Table/list body ≥13–14px computed; not ~11–12px “compact”
- [ ] Host theme tokens used; light/dark APCA polarity checked if both modes exist
- [ ] No fingernail lips (straight stripes or background only)
- [ ] Shell: nav + main + clear primary action (one primary for loaders)
- [ ] Tabular data in a real table when comparing records
- [ ] Filters shareable via URL/form
- [ ] Loading, empty, error present
- [ ] Destructive paths confirmed
- [ ] High-frequency chrome not animated
- [ ] Operator polish: attention strip / row emphasis / feedback where relevant
- [ ] Stack rules respected (no surprise React/Tailwind deps)
