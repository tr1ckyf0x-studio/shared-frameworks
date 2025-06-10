//
//  CoreDataService.swift
//  PersistenceCore
//
//  Created by Vladislav Lisianskii on 25.05.2025.
//  Copyright © 2025 Vladislav Lisianskii. All rights reserved.
//

import CoreData

// MARK: - CoreDataService

public final class CoreDataService: CoreDataServiceProtocol {

    public let persistentContainer: NSPersistentContainer

    public private(set) lazy var mainContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()

    private let managedObjectModel: NSManagedObjectModel
    private let storeType: StoreType

    // MARK: - Init

    public init(
        storeType: StoreType,
        persistentContainerName: String,
        managedObjectModelURL: URL
    ) {
        self.storeType = storeType

        let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelURL)
        guard let managedObjectModel else { fatalError("Cannot load Core Data model") }
        self.managedObjectModel = managedObjectModel

        persistentContainer = {
            let container = NSPersistentContainer(
                name: persistentContainerName,
                managedObjectModel: managedObjectModel
            )

            let descriptions = PersistentStoreDescriptionFactory.descriptions(for: storeType)
            container.persistentStoreDescriptions = descriptions

            return container
        }()

        createHostContainer()
    }
}

// MARK: - PersistentContainer

public enum StoreType {
    case sqlite(URL)
    case inMemory
}

private enum PersistentStoreDescriptionFactory {
    static func descriptions(for storeType: StoreType) -> [NSPersistentStoreDescription] {
        switch storeType {
        case let .sqlite(url):
            sqliteDescriptions(url: url)

        case .inMemory:
            inMemoryDescriptions()
        }
    }

    private static func sqliteDescriptions(url: URL) -> [NSPersistentStoreDescription] {
        let description = NSPersistentStoreDescription(url: url)
        description.type = NSSQLiteStoreType
        return [description]
    }

    private static func inMemoryDescriptions() -> [NSPersistentStoreDescription] {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        return [description]
    }
}
