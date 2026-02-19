# CLAUDE.md — SharedProtocolsAndModels

## Purpose
Thin, reusable protocols that encode common behavioral contracts across Fox Studio projects. No implementations beyond protocol default extensions.

## Public API

### `Mandatoryable`
- `var isMandatory: Bool { get }` — marks a field or item as required

### `MapsValue`
- Associated types: `Input`, `Output`
- `func mapValue(from object: Input?) -> Output` — value transformation algorithm

### `OpensURL`
- `#if canImport(UIKit)` only — unavailable in app extensions
- `func open(url: URL)` — opens a URL via the host application
- `UIApplication` extended to conform

### `RequestsReview`
- `static func requestReview()` — requests App Store review
- `SKStoreReviewController` extended to conform
- Requires `StoreKit`

### `ProvidesSharedInstance`
- `static var shared: Self { get }` — standard singleton contract

### `ProvidesWeakSharedInstanceTrait`
- Weak singleton: stores instance in a `weak` variable; lazily recreates when deallocated
- Default implementation provided; conforming types need only be `AnyObject`

### `Validable`
- `var isValid: Bool { get }` — validation contract for forms, inputs, models

### `ViewModelConfigurable`
- Associated type: `T`
- `func configure(with viewModel: T)` — binds a view model to a UI component (MVVM)

## Constraints
- Protocols only. Do not add concrete types or stored properties.
- `OpensURL` must stay behind `#if canImport(UIKit)` to remain macOS-compatible.
- No SwiftUI, CoreData, or UIKit imports at module level — conditional imports only.
- `ProvidesWeakSharedInstanceTrait` conformers must be classes (`AnyObject`).

## Dependencies
- `Foundation` (implicit)
- `UIKit` (conditional, `OpensURL` only)
- `StoreKit` (`RequestsReview` only)
