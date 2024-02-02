//
//  BottomSheetModalAnimator.swift
//
//  Created by Dmitry Stavitsky on 17.04.2023.
//

import UIKit

final class BottomSheetModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Configuration.transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.from
        )
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                from?.view.frame.origin.y = UIScreen.main.bounds.size.height
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}

// MARK: - Configuration

private extension BottomSheetModalAnimator {
    enum Configuration {
        static let transitionDuration = 0.33
    }
}
