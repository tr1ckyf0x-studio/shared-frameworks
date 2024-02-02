//
//  UITableView+Extensions.swift
//  SharedExtensions
//
//  Created by Dmitry Stavitsky on 05.07.2023.
//

import UIKit

public extension UITableView {
    /// Возвращает ячейку с авторегистрацией
    /// - Parameters:
    ///   - cellType: Тип ячейки
    ///   - reuseID: Идентификатор
    /// - Returns: Зарегистрированная ячейка
    func dequeueReusableCellWithAutoregistration<TCell: UITableViewCell>(
        _ cellType: TCell.Type,
        reuseID: String? = nil
    ) -> TCell {
        registerCell(cellType, reuseID: reuseID)
        let cell = dequeueReusableCell(cellType, reuseID: reuseID)
        assert(
            cell != nil,
            "UITableView can not dequeue cell with type \(cellType) for reuseID \(reuseID ?? defaultReuseID(of: cellType))"
        )
        guard let cell else { return TCell() }
        return cell
    }

    /// Возвращает ячейку без авторегистрации
    /// - Parameters:
    ///   - cellType: Тип ячейки
    ///   - reuseID: Идентификатор
    /// - Returns: Ячейка
    func dequeueReusableCell<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseID: String? = nil) -> TCell? {
        let normalizedReuseID = reuseID ?? defaultReuseID(of: cellType)
        return dequeueReusableCell(withIdentifier: normalizedReuseID) as? TCell
    }

    /// Регистрирует ячейку
    /// - Parameters:
    ///   - cellType: Тип ячейки
    ///   - reuseID: Идентификатор
    func registerCell<TCell: UITableViewCell>(_ cellType: TCell.Type, reuseID: String? = nil) {
        let normalizedReuseID = reuseID ?? defaultReuseID(of: cellType)
        register(cellType, forCellReuseIdentifier: normalizedReuseID)
    }
}

// MARK: - Private

private extension UITableView {
    func defaultReuseID(of cellType: UITableViewCell.Type) -> String {
        String(describing: cellType.self)
    }
}
