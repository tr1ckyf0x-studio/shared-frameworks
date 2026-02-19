# CLAUDE.md — SharedExtensions

## Purpose
Convenience extensions on standard Swift/Apple types. No app logic — pure utility.

## Public API

### `Array+Extensions`
- `subscript(safe index: Int) -> Element?` — returns nil for out-of-bounds instead of crashing; supports get and set

### `CGSize+Extensions`
- `var inverted: CGSize` — returns `CGSize(width: -width, height: -height)`; `@inlinable` for zero-cost abstraction

### `Date+Extensions`
- `func timeIntervalSinceStartOfDay(in calendar: Calendar = .current) -> TimeInterval` — seconds elapsed since midnight of the same calendar day

### `String+Extensions`
- `func filter(byAllowedCharacters characterSet: CharacterSet) -> String` — keeps only characters in the set
- `func replacingSubrange(_ range: Range<String.Index>, with replacement: String) -> String` — memory-efficient range replacement (pre-reserves capacity)

### `Sequence+Concurrency`
All methods are `async throws` unless noted.
- `asyncMap(_:)` — sequential async map
- `asyncCompactMap(_:)` — sequential async compact map
- `asyncForEach(_:)` — sequential async forEach
- `concurrentForEach(_:)` — parallel async forEach via `TaskGroup`
- `concurrentMap(_:)` — parallel async map (order preserved)
- `concurrentCompactMap(_:)` — parallel async compact map (order preserved)

## Patterns
- Extensions only — no new types.
- `@inlinable` on hot-path computed properties.
- Concurrent variants use `withThrowingTaskGroup`; do not share mutable state across closures.

## Constraints
- No UIKit/SwiftUI imports.
- Do not add extensions that carry business logic (e.g., domain-specific formatting).
- `CGSize+Extensions` requires `CoreGraphics` import.

## Dependencies
- `Foundation` — String, Date, CharacterSet
- `CoreGraphics` — CGSize

## Tests
`Tests/SharedExtensions/StringExtensionsTests.swift` — uses Swift Testing framework (`import Testing`).
Only `String` extensions are currently tested. Add tests alongside any new extension.
