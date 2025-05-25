//
//  UIImage+SFSymbol.swift
//  SharedProtocolsAndModels
//
//  Created by Vladislav Lisianskii on 21.05.2023.
//

#if canImport(UIKit)
import UIKit

extension UIImage {
    public convenience init?(
        sfSymbol: SFSymbolRepresentable,
        withConfiguration configuration: SymbolConfiguration? = nil
    ) {
        self.init(systemName: sfSymbol.systemName, withConfiguration: configuration)
    }
}
#endif
