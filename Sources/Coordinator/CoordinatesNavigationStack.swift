//
//  CoordinatesNavigationStack.swift
//  Coordinator
//
//  Created by Vladislav Lisianskii on 6. 1. 2026.
//  Copyright © 2026 Fox Studio. All rights reserved.
//

import SwiftUI

@MainActor
public protocol CoordinatesNavigationStack: AnyObject {
    associatedtype Page: Hashable

    var path: NavigationPath { get set }

    func push(page: Page)
    func pop()
    func popToRoot()
}

public extension CoordinatesNavigationStack {
    func push(page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
