//
//  Array+Extensions.swift
//  SharedExtensions
//
//  Created by Dmitry Stavitsky on 24.07.2023.
//

import Foundation

public extension Array {
    @inlinable
    @inline(__always)
    subscript(safe index: Int) -> Element? {
        get {
            guard index >= 0, index < count else { return nil }
            return self[index]
        }
        set {
            guard let newValue, index >= 0, index < count else { return }
            self[index] = newValue
        }
    }
}
