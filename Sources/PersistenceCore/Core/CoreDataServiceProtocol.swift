//
//  CoreDataServiceProtocol.swift
//  PersistenceCore
//
//  Created by Vladislav Lisianskii on 25.05.2025.
//  Copyright © 2025 Vladislav Lisianskii. All rights reserved.
//

import CoreData

public protocol CoreDataServiceProtocol: AnyObject {
    var persistentContainer: NSPersistentContainer { get }
    var mainContext: NSManagedObjectContext { get }

    /// Method has completion handler inside, but it is sync until shouldAddStoreAsynchronously equals true
    func createHostContainer()
}

extension CoreDataServiceProtocol {
    public func createHostContainer() {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
