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

## Usage Pattern
Conforming types are typically `ObservableObject` classes. Expose `path` and `sheet` as `@Published`.

```swift
@MainActor final class MyCoordinator: ObservableObject,
    CoordinatesNavigationStack, CoordinatesSheet {
    @Published var path = NavigationPath()
    @Published var sheet: MySheet?
}
```

## Constraints
- Both protocols are `@MainActor` — conforming types must also be `@MainActor` or isolated.
- `AnyObject` constraint — only classes can conform, not structs or enums.
- `Page` must be `Hashable` (required by `NavigationPath.append`).
- No UIKit dependency — SwiftUI only.

## Dependencies
- `SwiftUI` (Apple SDK) — required for `NavigationPath` in `CoordinatesNavigationStack`.
- `CoordinatesSheet` has no imports; `@MainActor` comes from the Swift standard library.
