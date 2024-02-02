//
//  Sequence+Concurrency.swift
//  SharedProtocolsAndModels
//
//  Created by Vladislav Lisianskii on 22.05.2023.
//

import Foundation

extension Sequence {
    /// Позволяет использовать async контекст внутри transform
    public func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }

    /// Позволяет использовать async контекст внутри transform
    public func asyncCompactMap<T>(
        _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            guard let value = try await transform(element) else { continue }
            values.append(value)
        }

        return values
    }

    /// Позволяет использовать async контекст внутри transform
    public func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }

    /// Позволяет выполнять операции параллельно
    public func concurrentForEach(
        _ operation: @escaping (Element) async -> Void
    ) async {
        // A task group automatically waits for all of its
        // sub-tasks to complete, while also performing those
        // tasks in parallel:
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await operation(element)
                }
            }
        }
    }

    /// Позволяет выполнять трансформации параллельно
    public func concurrentMap<T>(
        _ transform: @escaping (Element) async throws -> T
    ) async rethrows -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }

        return try await tasks.asyncMap { task in
            try await task.value
        }
    }

    /// Позволяет выполнять трансформации параллельно
    public func concurrentCompactMap<T>(
        _ transform: @escaping (Element) async throws -> T?
    ) async rethrows -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }

        return try await tasks.asyncCompactMap { task in
            try await task.value
        }
    }
}
