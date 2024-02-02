//
//  Array+Extensions.swift
//  SharedExtensions
//
//  Created by Dmitry Stavitsky on 24.07.2023.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        get {
            0..<self.count ~= index ? self[index] : nil
        }
        set(newValue) {
            if 0..<self.count ~= index, let newValue = newValue {
                self[index] = newValue
            }
        }
    }
}
