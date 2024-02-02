//
//  BottomSheetModalPresentationController.swift
//
//  Created by Dmitry Stavitsky on 17.04.2023.
//

import SnapKit
import UIKit

final class BottomSheetModalPresentationController: UIPresentationController {
    // MARK: - Properties

    private let appearance = Appearance(); struct Appearance {
        let cornerRadius: CGFloat = 12
        let dimmingViewColor = UIColor(white: .zero, alpha: 0.3)
    }

    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.dimmingViewColor
        view.addGestureRecognizer({
            let gestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(handleTap(recognizer:))
            )
            gestureRecognizer.cancelsTouchesInView = false
            return gestureRecognizer
        }())
        return view
    }()

    // MARK: - Init

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        applyAppearance()
        registerForKeyboardNotifications()
    }

    // MARK: - Override

    override var presentedView: UIView? {
        contentView
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        addPresentedViewInCustomViews()
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        addCustomViews()
        addPresentedViewInCustomViews()
        animateDimmingViewIn()
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        guard !completed else { return }
        removeCustomViews()
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        animateDimmingViewOut()
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        guard completed else { return }
        removeCustomViews()
    }
}

// MARK: - Keyboard Handling

private extension BottomSheetModalPresentationController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardToggled(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardToggled(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardToggled(notification: NSNotification) {
        guard
            let containerHeight = containerView?.bounds.height,
            let presentedView = presentedView
        else {
            return
        }

        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            guard
                let keyboardFrameEndUserInfo = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey],
                let keyboardFrame = (keyboardFrameEndUserInfo as? NSValue)?.cgRectValue
            else {
                return
            }
            let keyboardOverlap = presentedView.frame.maxY - keyboardFrame.minY
            let statusBarHeight = presentedView.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
            presentedView.frame.origin.y = max(presentedView.frame.minY - keyboardOverlap, statusBarHeight)

        case UIResponder.keyboardWillHideNotification:
            presentedView.frame.origin.y = containerHeight - presentedView.frame.size.height

        default:
            return
        }
    }
}

// MARK: - Private

private extension BottomSheetModalPresentationController {
    func addCustomViews() {
        guard let containerView else {
            assertionFailure("Can't set up custom views without a container view. Transition must not be started yet.")
            return
        }

        containerView.addSubview(dimmingView)
        containerView.addSubview(contentView)

        dimmingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }

        // TODO: Refactor using SnapKit
        NSLayoutConstraint.activate([
            // Fit the card to the bottom of the screen within the readable width.
            contentView.topAnchor.constraint(
                greaterThanOrEqualToSystemSpacingBelow: containerView.readableContentGuide.topAnchor,
                multiplier: 1
            ),
            {
                // Weakly squeeze the content toward the bottom. This functions
                // just like the `verticalFittingPriority` in
                // `UIView.systemLayoutSizeFitting` to get the card to try
                // and fit its content while meeting the other constrainnts.
                let minimizingHeight = contentView.heightAnchor.constraint(equalToConstant: .zero)
                minimizingHeight.priority = .fittingSizeLevel
                return minimizingHeight
            }()
        ])
    }

    func addPresentedViewInCustomViews() {
        if presentedViewController.view.isDescendant(of: contentView) { return }
        contentView.addSubview(presentedViewController.view)
        presentedViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func removeCustomViews() {
        contentView.removeFromSuperview()
        dimmingView.removeFromSuperview()
    }

    func animateDimmingViewIn() {
        dimmingView.alpha = .zero
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }

    func animateDimmingViewOut() {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = .zero
        })
    }

    func applyAppearance() {
        presentedViewController.view.clipsToBounds = true
        presentedViewController.view.layer.cornerRadius = appearance.cornerRadius
        presentedViewController.view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }
}
