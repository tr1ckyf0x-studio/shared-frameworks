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
        filter { (character: Character) -> Bool in
            !character.unicodeScalars.contains { (unicodeScalar: Unicode.Scalar) -> Bool in
                !allowedCharacters.contains(unicodeScalar)
            }
        }
    }

    /// Заменяет subrange на переданную строку
    func replacingSubrange(_ subrange: Range<Index>, with string: any StringProtocol) -> String {
        var mutable = self
        mutable.replaceSubrange(subrange, with: string)
        return mutable
    }
}
