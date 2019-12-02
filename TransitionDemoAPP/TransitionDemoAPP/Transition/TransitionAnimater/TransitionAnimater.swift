//
//  TransitionAnimater.swift
//  AppStoreDemo
//
//  Created by 汤军 on 2019/11/14.
//  Copyright © 2019 Utimes. All rights reserved.
//

import UIKit

public protocol TransitionAnimaterDelegate {
    func animationForPresent(using transitionContext: UIViewControllerContextTransitioning)
    func animationForDismiss(using transitionContext: UIViewControllerContextTransitioning)
    func animationForPush(using transitionContext: UIViewControllerContextTransitioning)
    func animationForPop(using transitionContext: UIViewControllerContextTransitioning)
}

public enum TransitionAnimaterType {
    case present
    case dismiss
    case push
    case pop
}

public class TransitionAnimater: NSObject, TransitionAnimaterDelegate {

    private let type: TransitionAnimaterType

    public var duration: TimeInterval = 1.0

    init(type: TransitionAnimaterType) {
        self.type = type
        super.init()
    }

    //should override by sub class
    public func animationForPop(using transitionContext: UIViewControllerContextTransitioning) { }
    public func animationForPush(using transitionContext: UIViewControllerContextTransitioning) { }
    public func animationForDismiss(using transitionContext: UIViewControllerContextTransitioning) { }
    public func animationForPresent(using transitionContext: UIViewControllerContextTransitioning) { }
    public func animationEnded(_ transitionCompleted: Bool) { }
}

extension TransitionAnimater: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            animationForPresent(using: transitionContext)
        case .dismiss:
            animationForDismiss(using: transitionContext)
        case .push:
            animationForPush(using: transitionContext)
        case .pop:
            animationForPop(using: transitionContext)
        }
    }
}
