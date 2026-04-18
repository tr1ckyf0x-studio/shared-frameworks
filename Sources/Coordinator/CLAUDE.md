# CLAUDE.md — Coordinator

## Purpose
Protocol-based coordinator pattern for SwiftUI navigation. Separates navigation logic from views.

## Public API

### `CoordinatesNavigationStack`
- Constraint: `@MainActor`, `AnyObject`
- Associated type: `Page: Hashable`
- Required property: `var path: NavigationPath { get set }`
- Methods (default implementations provided): `push(page:)`, `pop()`, `popToRoot()`
- Backed by SwiftUI `NavigationPath`

### `CoordinatesSheet`
- Constraint: `@MainActor`, `AnyObject`
- Associated type: `Sheet` (no constraint)
- Required property: `var sheet: Sheet? { get set }`
- Methods (default implementations provided): `presentSheet(_:)`, `dismissSheet()`
- Sheet state is driven by optional value binding

### `CoordinatesNavigationSplitView`
- Constraint: `@MainActor`, `AnyObject`
- Associated type: `SidebarItem: Hashable`
- Required property: `var selectedSidebarItem: SidebarItem? { get set }`
- Method (default implementation provided): `selectSidebarItem(_:)`
- Single-selection model for `NavigationSplitView` sidebars on macOS (and single-selection lists on iPad).
- Detail-pane state is intentionally **not** part of this protocol — detail state varies per feature and belongs in feature-specific view models.

## Usage Pattern
Conforming types are typically `ObservableObject` or `@Observable` classes that expose `path`, `sheet`, and/or `selectedSidebarItem`.

```swift
@MainActor final class MyCoordinator: ObservableObject,
    CoordinatesNavigationStack, CoordinatesSheet, CoordinatesNavigationSplitView {
    @Published var path = NavigationPath()
    @Published var sheet: MySheet?
    @Published var selectedSidebarItem: MySidebarItem?
}
```

## Constraints
- All three protocols are `@MainActor` — conforming types must also be `@MainActor` or isolated.
- `AnyObject` constraint — only classes can conform, not structs or enums.
- `Page` must be `Hashable` (required by `NavigationPath.append`).
- `SidebarItem` must be `Hashable` (required by `List(selection:)`).
- No UIKit dependency — SwiftUI only.

## Dependencies
- `SwiftUI` (Apple SDK) — required for `NavigationPath` in `CoordinatesNavigationStack`.
- `CoordinatesSheet` has no imports; `@MainActor` comes from the Swift standard library.
