//
//  ViewModelConfigurable.swift
//  DesignSystem
//
//  Created by Dmitry Stavitsky on 12.01.2023.
//

import Foundation

public protocol ViewModelConfigurable<T> {
    associatedtype T

    func configure(with viewModel: T)
}
