//
//  NSManagedObjectContext + Extensions.swift
//  PersistenceCore
//
//  Created by Dmitry on 25.07.2020.
//  Copyright © 2020 Vladislav Lisianskii. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    public func insertObject<T: NSManagedObject>() -> T where T: Managed {
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: T.entityName,
            into: self
        ) as? T else { fatalError("\(self) : Wrong object type") }
        return object
    }
}
