# CLAUDE.md — PersistenceCore

## Purpose
Core Data abstraction layer. Provides a typed service for setting up persistent containers, creating contexts, inserting managed objects, and saving recursively up the context hierarchy.

## Public API

### `CoreDataServiceProtocol`
- `var persistentContainer: NSPersistentContainer { get }`
- `var mainContext: NSManagedObjectContext { get }`
- `func createHostContainer() async throws` — loads persistent stores (default implementation included)

### `CoreDataService: CoreDataServiceProtocol`
- Initializer: `init(storeType:containerName:modelURL:)`
- `storeType`: `.sqlite(url: URL)` or `.inMemory`
- `mainContext` is lazily initialized; merges changes from child contexts automatically

### `Managed` (protocol on `NSManagedObject` subclasses)
- `static var entityName: String` — defaults to Core Data entity name via `entity().name!`
- `static var defaultSortDescriptors: [NSSortDescriptor]`
- `static var sortedFetchRequest: NSFetchRequest<Self>` — default implementation using above

### `NSManagedObjectContext` extensions
- `func insertObject<T: NSManagedObject & Managed>() -> T` — type-safe `NSEntityDescription.insertNewObject`
- `func createChildContext(kind:) -> NSManagedObjectContext` — creates main or private queue child context
- `func saveRecursively() async throws` — saves self then recursively saves parent context
- `func saveRecursively(completionHandler:)` — callback variant; calls handler on main queue

## Patterns
- Use `inMemory` store for tests.
- `saveRecursively` is async-safe; do not call `context.save()` directly — always go through this helper.
- `insertObject<T>()` requires `T` to conform to both `NSManagedObject` and `Managed`.

## Constraints
- No SwiftUI dependency.
- `CoreDataService` is not thread-safe itself; use `mainContext` on main thread and create child contexts for background work.
- `modelURL` must point to a compiled `.momd` bundle resource.

## Dependencies
- `Foundation`, `CoreData` (Apple SDK)
