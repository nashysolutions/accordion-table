# AccordionTable

A small wrapper around Apple’s diffable data source API that enables **collapsible table view sections** in a **predictable, explicit way**.

Designed for UIKit codebases that want accordion-style behaviour **without leaking UI state into models or snapshots**.

---

## Why this exists

In UIKit apps that use diffable data sources, collapsible sections are a common requirement — settings screens, filters, grouped lists, etc.

In production codebases, this often leads to the same set of trade-offs appearing repeatedly:
- UI selection or expansion state creeping into models
- `Hashable` conformance being distorted to force reload behaviour
- Accordion logic spread across view controllers and delegates
- Snapshot updates that are difficult to reason about or debug

This library is a deliberate response to those patterns.

It provides a small, explicit layer that manages accordion behaviour **without violating the core assumptions of diffable data sources**:
- snapshots describe data, not UI state
- identity remains stable and meaningful
- interaction state is tracked separately and predictably

The goal is not to abstract UIKit, but to make a common interaction pattern easier to implement **consistently and safely** across a real codebase.

---

## What it is

- A lightweight wrapper over `UITableViewDiffableDataSource`
- Manages expandable / collapsible sections
- Explicitly tracks selection state outside of snapshots
- Requires no magic
- Designed to be easy to reason about and debug

---

## What it deliberately avoids

- Implicit state hidden in models
- Mutating hashable values to drive UI
- Custom table view subclasses
- Non-deterministic reload behaviour
- Cleverness that fights Apple’s APIs

---

## Example behaviour

<img src="https://user-images.githubusercontent.com/64097812/150280515-64bbcc1b-ba85-4c56-bd4a-0b77be008e8c.gif" width="300"/>

---

## Usage overview

At a high level, you:

1. Create a normal diffable data source
2. Wrap it in `AccordionTable`
3. Forward a small set of delegate events
4. Update snapshots as usual

The library handles the rest.

A full, real-world example can be seen here:  
👉 https://github.com/nashysolutions/MeltingList/blob/main/MeltingList/ListViewController.swift

---

## Minimal setup

```swift
let dataSource = UITableViewDiffableDataSource<Section, Row>(
    tableView: tableView,
    cellProvider: cellProvider
)

let accordionTable = AccordionTable<Section, Row>(
    dataSource: dataSource,
    headerProvider: headerProvider
)

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    accordionTable.viewForHeader(in: tableView, at: section)
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    accordionTable.toggleSelectedStateForRow(at: indexPath)
}
```

Forward relevant delegate callbacks:

```swift
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    accordionTable.viewForHeader(in: tableView, at: section)
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    accordionTable.toggleSelectedStateForRow(at: indexPath)
}
```

Update data using your existing diffable snapshots.


## Design principles

* UI state is not model state
Selection and expansion are tracked independently from snapshot data.
* Diffable snapshots stay pure
Hashable conformance reflects identity, not UI concerns.
* Explicit over clever
Behaviour is driven by clear calls, not side effects.
* Predictable updates
No unexpected reloads or section churn.

⸻

## When to use this

Use AccordionTable if you:

* already use diffable data sources
* want collapsible sections
* care about predictable behaviour
* want to keep view controller code boring and readable

If you’re building a fully custom list system or want SwiftUI-style declarative state, this is probably not the right tool.
