//
//  PersistentContainer.swift
//  Database
//
//  Created by Vladislav Lisianskii on 18.05.2023.
//

import CoreData

// MARK: - PersistentContainerType

public protocol PersistentContainerType {
    static var store: String { get }
    static var persistentStoreDescriptions: [NSPersistentStoreDescription]? { get }
}

// MARK: - PersistentContainer

public enum PersistentContainer {
    public struct SQLite: PersistentContainerType {
        public static let store = NSSQLiteStoreType
        public static let persistentStoreDescriptions: [NSPersistentStoreDescription]? = nil
    }

    public struct InMemory: PersistentContainerType {
        public static let store = NSInMemoryStoreType
        public static let persistentStoreDescriptions: [NSPersistentStoreDescription]? = {
            let description = NSPersistentStoreDescription()
            description.type = store
            return [description]
        }()
    }
}
