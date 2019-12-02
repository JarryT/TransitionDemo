//
//  BlurPresentationController.swift
//  AppStoreDemo
//
//  Created by 汤军 on 2019/11/14.
//  Copyright © 2019 Utimes. All rights reserved.
//

import UIKit

public class BlurPresentationController: UIPresentationController {

    private lazy var blurView = UIVisualEffectView(effect: nil)

    override public var shouldRemovePresentersView: Bool {
        return false
    }

    override public func presentationTransitionWillBegin() {
        let container = containerView!
        blurView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(blurView)
        blurView.edges(to: container)
        blurView.alpha = 0.0

        presentingViewController.beginAppearanceTransition(false, animated: false)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            self.blurView.effect = UIBlurEffect(style: .light)
            self.blurView.alpha = 1
        }) { (ctx) in }
    }

    override public func presentationTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }

    override public func dismissalTransitionWillBegin() {
        presentingViewController.beginAppearanceTransition(true, animated: true)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            self.blurView.alpha = 0.0
        }, completion: nil)
    }

    override public func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
        if completed {
            blurView.removeFromSuperview()
        }
    }
}

private extension UIView {
    // Constrain 4 edges of `self` to specified `view`.
    func edges(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
}
