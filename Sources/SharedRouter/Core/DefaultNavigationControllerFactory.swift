//
//  DefaultNavigationControllerFactory.swift
//  SharedRouter
//
//  Created by Dmitry Stavitsky on 31.05.2023.
//

import RouteComposer
import UIKit

/// Default factory implementation which creates `UINavigationController`
public struct DefaultNavigationControllerFactory: SimpleContainerFactory {

    // MARK: Associated types

    public typealias ViewController = UINavigationController

    public typealias Context = Void

    public typealias ConfigurationClosure = (_ viewController: ViewController) -> Void

    // MARK: - Properties

    /// Reference to `UINavigationControllerDelegate`
    public private(set) weak var delegate: UINavigationControllerDelegate?

    /// Configuration closure
    public let configuration: ConfigurationClosure?

    // MARK: - Init

    public init(
        delegate: UINavigationControllerDelegate? = nil,
        configuration: ConfigurationClosure? = nil
    ) {
        self.delegate = delegate
        self.configuration = configuration
    }

    // MARK: - SimpleContainerFactory

    public func build(with _: Context, integrating viewControllers: [UIViewController]) throws -> ViewController {
        guard !viewControllers.isEmpty else {
            throw RoutingError.compositionFailed(RoutingError.Context(
                "Unable to build NavigationController without child view controllers"
            ))
        }
        let viewController = ViewController()
        configuration?(viewController)
        viewController.delegate = delegate
        viewController.viewControllers = viewControllers

        return viewController
    }
}
