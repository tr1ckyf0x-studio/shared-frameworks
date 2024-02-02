//
//  CoreDataService.swift
//  PersistenceCore
//
//  Created by Vladislav Lisianskii on 01.07.2023.
//

import CocoaLumberjack
import CoreData

open class CoreDataService: ManagesCoreData {

    // MARK: - Properties

    public private(set) lazy final var concurrentContext = persistentContainer.newBackgroundContext()

    public private(set) lazy final var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(
            concurrencyType: .mainQueueConcurrencyType
        )

        context.automaticallyMergesChangesFromParent = true
        context.parent = concurrentContext
        return context
    }()

    private let persistentContainer: NSPersistentContainer

    private let persistentContainerType: PersistentContainerType.Type

    // MARK: - Init

    public init(
        persistentContainerType: PersistentContainerType.Type,
        managedObjectModel: NSManagedObjectModel,
        persistentContainerName: String
    ) {
        self.persistentContainerType = persistentContainerType

        persistentContainer = NSPersistentContainer(
            name: persistentContainerName,
            managedObjectModel: managedObjectModel
        )

        if let persistentStoreDescriptions = persistentContainerType.persistentStoreDescriptions {
            persistentContainer.persistentStoreDescriptions = persistentStoreDescriptions
        }

        loadContainer()
    }
}

// MARK: - Private

private extension CoreDataService {
    /// Method has completion handler inside, but it is sync until shouldAddStoreAsynchronously equals true
    func loadContainer() {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                DDLogError("Persistent stores were not loaded due to error: \(error)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
