//
//  NSManagedObjectContext + Extensions.swift
//  PersistenceCore
//
//  Created by Dmitry on 25.07.2020.
//  Copyright © 2020 Vladislav Lisianskii. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    func insertObject<T: NSManagedObject>() -> T where T: Managed {
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: T.entityName,
            into: self
        ) as? T else { fatalError("\(self) : Wrong object type") }
        return object
    }

    func createChildContext(kind: ContextKind) -> NSManagedObjectContext {
        let childContext = NSManagedObjectContext(concurrencyType: kind.currencyType)
        childContext.parent = self
        return childContext
    }


}

public extension NSManagedObjectContext {
    typealias SaveCompletionHandler = (Error?) -> Void

    /// Рекурсивно сохраняет контекст. По завершении вызывает completionHandler на `DispatchQueue.main`
    func saveRecursively(completionHandler: SaveCompletionHandler? = nil) {
        func finish(_ error: Error? = nil) {
            DispatchQueue.main.async { completionHandler?(error)  }
        }

        Task {
            do {
                try await saveRecursively()
                finish()
            } catch {
                finish(error)
            }
        }
    }

    /// Рекурсивно сохраняет контекст.
    func saveRecursively() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
            perform { [self] in
                guard hasChanges else { return continuation.resume() }

                do {
                    try save()
                    if let parent {
                        Task {
                            try await parent.saveRecursively()
                            continuation.resume()
                        }
                    } else {
                        continuation.resume()
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

public extension NSManagedObjectContext {
    enum ContextKind {
        case main
        case concurrent

        fileprivate var currencyType: NSManagedObjectContextConcurrencyType {
            return switch self {
            case .main: .mainQueueConcurrencyType
            case .concurrent: .privateQueueConcurrencyType
            }
        }
    }
}
