# CLAUDE.md — shared-frameworks

## Repo Identity
Swift Package. Reusable libraries for Fox Studio projects. No app target — libraries only.

## Module Inventory

| Target | Product | Purpose |
|--------|---------|---------|
| `Coordinator` | `Coordinator` | SwiftUI coordinator protocols (nav stack + sheets) |
| `PersistenceCore` | `PersistenceCore` | Core Data stack abstraction |
| `SharedExtensions` | `SharedExtensions` | Swift/Apple type extensions |
| `SharedProtocolsAndModels` | `SharedProtocolsAndModels` | Cross-project protocols |
| `SharedExtensionsTests` | — | Test target for SharedExtensions |

## Platform Constraints
- iOS 16+ / macOS 13+ (set in Package.swift `platforms:`)
- Swift tools version: 5.9
- No external (non-Apple) dependencies — keep it that way

## Architecture Rules
- Protocol-oriented. Add protocols before concrete types.
- No concrete implementations that carry app-specific business logic.
- `@MainActor` required on any protocol that touches SwiftUI state.
- AnyObject constraint required on `@MainActor` protocols (class-bound).
- No `import UIKit` in macOS-compatible targets. Use `#if canImport(UIKit)` guards.

## Adding a New Module (Checklist)
1. Create `Sources/<ModuleName>/` directory with at least one `.swift` file.
2. Add `.library(name: "<ModuleName>", targets: ["<ModuleName>"])` to `products:` in `Package.swift`.
3. Add `.target(name: "<ModuleName>")` to `targets:` in `Package.swift`.
4. Create `Sources/<ModuleName>/CLAUDE.md` describing the module API.
5. Add an entry to `CHANGELOG.md` under a new version.
6. Document the module in `README.md`.

## Test Patterns
- Framework: **Swift Testing** (`import Testing`), NOT XCTest.
- Test files live in `Tests/<TargetName>/`.
- Test structs use `@Suite` / `@Test` macros.
- Run: `swift test` from package root.

## Versioning
- Semantic versioning. Format in CHANGELOG: `## [X.Y.Z] - DD-MM-YYYY`.
- Breaking changes → major bump. New modules/features → minor bump. Fixes → patch.

## Key File Paths
- `Package.swift` — single source of truth for targets/products/platforms
- `Sources/Coordinator/` — SwiftUI navigation coordinator protocols
- `Sources/PersistenceCore/` — Core Data service + Managed protocol
- `Sources/SharedExtensions/` — Array, String, Date, CGSize, Sequence extensions
- `Sources/SharedProtocolsAndModels/` — Validable, MapsValue, ProvidesSharedInstance, etc.
- `Tests/SharedExtensions/` — String extension tests
