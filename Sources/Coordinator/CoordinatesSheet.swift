//
//  CoordinatesSheet.swift
//  Coordinator
//
//  Created by Vladislav Lisianskii on 6. 1. 2026.
//  Copyright © 2026 Fox Studio. All rights reserved.
//

@MainActor
public protocol CoordinatesSheet: AnyObject {
    associatedtype Sheet

    var sheet: Sheet? { get set }

    func presentSheet(_ sheet: Sheet)
    func dismissSheet()
}

public extension CoordinatesSheet {
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func dismissSheet() {
        self.sheet = nil
    }
}
