//
//  NSManagedObjectContext+Extensions.swift
//  Database
//
//  Created by Vladislav Lisianskii on 19.05.2023.
//

import CocoaLumberjack
import CoreData

extension NSManagedObjectContext {
    public func insertObject<T: NSManagedObject>() -> T where T: Managed {
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: T.entityName,
            into: self
        ) as? T else { fatalError(" \(self) : Wrong object type") }
        return object
    }

    /// Рекурсивно сохраняет контекст от текущего к родительским
    public func saveRecursively() throws {
        try performAndWait {
            guard hasChanges else {
                DDLogDebug("Context does not contain any changes. Save will not be performed")
                return
            }

            try save()

            if let parent {
                try parent.performAndWait {
                    try parent.saveRecursively()
                }
            }
        }
    }
}
