//
//  CoreDataServiceProtocol.swift
//  PersistenceCore
//
//  Created by Vladislav Lisianskii on 25.05.2025.
//  Copyright © 2025 Vladislav Lisianskii. All rights reserved.
//

import CoreData
import Logger

public protocol CoreDataServiceProtocol: AnyObject {
    typealias SaveCompletionHandler = () -> Void

    var persistentContainer: NSPersistentContainer { get }
    var mainContext: NSManagedObjectContext { get }

    /// Method has completion handler inside, but it is sync until shouldAddStoreAsynchronously equals true
    func createHostContainer()

    /// Асинхронно сохраняет переданный контекст и всех родителей, по завершении вызывает completionHandler
    func saveRecursively(
        _ context: NSManagedObjectContext,
        completionHandler: SaveCompletionHandler?
    )
}

public extension NSManagedObjectContext {
    func createChildContext(kind: ContextKind) -> NSManagedObjectContext {
        let concurrencyType = kind.currencyType
        let childContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        childContext.parent = self
        return childContext
    }

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

extension CoreDataServiceProtocol {
    public func createHostContainer() {
        persistentContainer.loadPersistentStores { [logger] _, error in
            if let error = error as NSError? {
                logger?.logError(message: "Persistent stores were not loaded due to error: \(error)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            logger?.logDebug(message: "Persistent stores were loaded")
        }
    }

    public func saveRecursively(
        _ context: NSManagedObjectContext,
        completionHandler: SaveCompletionHandler? = nil
    ) {
        context.perform { [self] in
            guard context.hasChanges else {
                logger?.logDebug(message: "No changed is \(context)")
                DispatchQueue.main.async { completionHandler?() }
                return
            }

            do {
                try context.save()
                logger?.logDebug(message: "Saved context \(context)")

                if let parent = context.parent {
                    saveRecursively(parent, completionHandler: completionHandler)
                } else {
                    DispatchQueue.main.async { completionHandler?() }
                }
            } catch {
                logger?.logError(message: "Failed to save \(context): \(error)")
                DispatchQueue.main.async { completionHandler?() }
            }
        }
    }
}

private extension CoreDataServiceProtocol {
    var logger: Logger? {
        guard let self = self as? HasLogger else { return nil }
        return self.logger
    }
}
