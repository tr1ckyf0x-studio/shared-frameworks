//
//  SFSymbol.swift
//  DesignSystem
//
//  Created by Vladislav Lisianskii on 21.05.2023.
//

public enum SFSymbol: String, SFSymbolRepresentable {
    case book
    case checkmark
    case chevronRight = "chevron.right"
    case drop
    case gear
    case house
    case plus
    case questionmark
    case star = "star.fill"
    case stop = "stop.circle"
    case trash
    case pencil
}

// MARK: - SFSymbolRepresentable

public protocol SFSymbolRepresentable {
    var systemName: String { get }
}

public extension SFSymbolRepresentable where Self: RawRepresentable, RawValue == String {
    var systemName: String { rawValue }
}
