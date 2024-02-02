//
//  IRouter.swift
//  SharedRouter
//
//  Created by Dmitry Stavitsky on 16.10.2022.
//

import RouteComposer

public struct IRouter {

    // MARK: - Properties

    /// Router which performs application navigation
    public let defaultRouter: Router
    /// Iterator which is responsible for navigation
    public let defaultStackIterator: StackIterator

    // MARK: - Init

    public init(
        defaultRouter: Router = DefaultRouter(),
        defaultStackIterator: StackIterator = RouteComposerDefaults.shared.stackIterator
    ) {
        self.defaultRouter = defaultRouter
        self.defaultStackIterator = defaultStackIterator
    }
}
