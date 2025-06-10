//
//  String+Extensions.swift
//  SharedExtensions
//
//  Created by Vladislav Lisianskii on 30.05.2023.
//

import Foundation

public extension String {
    /// Удаляет из строки все символы, кроме разрешенных
    func filter(byAllowedCharacters allowedCharacters: CharacterSet) -> String {
        let filteredScalars = unicodeScalars.filter { allowedCharacters.contains($0) }
        return String(filteredScalars)
    }

    /// Заменяет subrange на переданную строку
    func replacingSubrange(_ subrange: Range<Index>, with replacement: any StringProtocol) -> String {
        let removedCount = self.distance(
            from: subrange.lowerBound,
            to: subrange.upperBound
        )
        let newCount = self.count - removedCount + replacement.count

        var result = String()
        result.reserveCapacity(newCount)

        result.append(contentsOf: self[..<subrange.lowerBound])
        result.append(contentsOf: replacement)
        result.append(contentsOf: self[subrange.upperBound...])

        return result
    }
}
