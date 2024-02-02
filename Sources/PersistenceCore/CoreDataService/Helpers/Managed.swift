//
//  Managed.swift
//  Database
//
//  Created by Vladislav Lisianskii on 19.05.2023.
//

import CoreData

public protocol Managed: NSFetchRequestResult {
    static var entityName: String { get }
    static var sortedFetchRequest: NSFetchRequest<Self> { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

public extension Managed where Self: NSManagedObject {
    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }

    static var entityName: String {
        guard let name = entity().name else {
            fatalError("Name for entity \(self) is not assigned!")
        }
        return name
    }

    static var defaultSortDescriptors: [NSSortDescriptor] {
        []
    }

}
