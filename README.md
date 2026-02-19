# Shared Frameworks

A Swift Package containing reusable libraries shared across Fox Studio projects.

## Modules

| Module | Description |
|--------|-------------|
| **Coordinator** | Protocol-based coordinator pattern for SwiftUI navigation stacks and sheet presentation |
| **PersistenceCore** | Core Data abstraction layer — persistent container setup, managed object utilities, recursive context saving |
| **SharedExtensions** | Extensions for standard Swift/Apple types: `Array`, `String`, `Date`, `CGSize`, and async `Sequence` operations |
| **SharedProtocolsAndModels** | Common protocols for validation, value mapping, singletons, MVVM configuration, and StoreKit/URL handling |

## Requirements

- **Swift** 5.9+
- **iOS** 16+
- **macOS** 13+

## Installation

Add the package via Swift Package Manager in Xcode or `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/tr1ckyf0x-studio/shared-frameworks.git", from: "1.1.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "Coordinator", package: "shared-frameworks"),
            .product(name: "PersistenceCore", package: "shared-frameworks"),
            .product(name: "SharedExtensions", package: "shared-frameworks"),
            .product(name: "SharedProtocolsAndModels", package: "shared-frameworks"),
        ]
    )
]
```

Import only the modules you need — each library is independently linkable.

## Usage

### Coordinator

Implement `CoordinatesNavigationStack` to manage a SwiftUI `NavigationStack`:

```swift
import Coordinator
import SwiftUI

enum AppPage: Hashable { case detail(id: Int) }

@MainActor
final class AppCoordinator: ObservableObject, CoordinatesNavigationStack {
    @Published var path = NavigationPath()
    // push/pop/popToRoot are provided by default implementations
}
```

Implement `CoordinatesSheet` for modal presentation:

```swift
@MainActor
final class AppCoordinator: ObservableObject, CoordinatesSheet {
    enum AppSheet { case settings }
    @Published var sheet: AppSheet?
    // presentSheet/dismissSheet are provided by default implementations
}
```

### PersistenceCore

```swift
import PersistenceCore

let service = CoreDataService(
    storeType: .sqlite(url: storeURL),
    containerName: "MyModel",
    modelURL: Bundle.main.url(forResource: "MyModel", withExtension: "momd")!
)
try await service.createHostContainer()
```

### SharedExtensions

```swift
import SharedExtensions

// Safe array subscript
let element = array[safe: index]

// Async sequence mapping
let results = try await items.asyncMap { try await fetch($0) }

// Parallel mapping
let results = try await items.concurrentMap { process($0) }
```

### SharedProtocolsAndModels

```swift
import SharedProtocolsAndModels

// Validation
struct LoginForm: Validable {
    var isValid: Bool { !username.isEmpty && !password.isEmpty }
}

// Value mapping
struct UserMapper: MapsValue {
    typealias Input = UserDTO
    typealias Output = User
    func mapValue(from object: UserDTO?) -> User { ... }
}
```

## License

Copyright © 2026 Fox Studio. All rights reserved.
