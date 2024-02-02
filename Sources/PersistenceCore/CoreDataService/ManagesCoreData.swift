//
//  ManagesCoreData.swift
//  Database
//
//  Created by Vladislav Lisianskii on 18.05.2023.
//

import CoreData

public protocol ManagesCoreData: AnyObject {
    var mainContext: NSManagedObjectContext { get }
    var concurrentContext: NSManagedObjectContext { get }
}
