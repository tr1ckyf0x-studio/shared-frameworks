//
//  UIControl+Extensions.swift
//  SharedExtensions
//
//  Created by Vladislav Lisianskii on 30.05.2023.
//

import UIKit

public extension UIControl {
    /// Удаляет все таргеты и UIAction
    func removeAllActions() {
        enumerateEventHandlers { action, targetAction, event, _ in
            if let action {
                removeAction(action, for: event)
            }
            if let (target, selector) = targetAction {
                removeTarget(target, action: selector, for: event)
            }
        }
    }
}
