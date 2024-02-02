//
//  ProvidesTableViewCell.swift
//  Insulin
//
//  Created by Dmitry Stavitsky on 21.01.2023.
//

import UIKit

public protocol ProvidesTableViewCell<ItemIdentifierType> {
    associatedtype ItemIdentifierType: Hashable, Sendable

    func makeTableViewCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ itemIdentifier: ItemIdentifierType
    ) -> UITableViewCell?
}
