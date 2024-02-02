//
//  BottomSheetModalTransitionDelegate.swift
//
//  Created by Dmitry Stavitsky on 17.04.2023.
//

import UIKit

public final class BottomSheetModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        BottomSheetModalAnimator()
    }

    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        BottomSheetModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
