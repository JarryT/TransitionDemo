//
//  UIScaleViewController.swift
//  AppStoreDemo
//
//  Created by 汤军 on 2019/11/14.
//  Copyright © 2019 Utimes. All rights reserved.
//

import UIKit


/// add pull down scale animation
public class UIScaleViewController: UIViewController, ScaleAnimationProtocol {

    public var isScaleAnimationEnable: Bool = true

    public var isScaleToDissmissEnable: Bool = true

    public var startPoint: CGPoint?

    private lazy var dismissPanGesture: UIPanGestureRecognizer = {
        let ges = UIPanGestureRecognizer()
        ges.maximumNumberOfTouches = 1
        ges.addTarget(self, action: #selector(handleDismissPan(gesture:)))
        ges.delegate = self
        return ges
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(dismissPanGesture)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.removeGestureRecognizer(dismissPanGesture)
    }

    /// should be override by sub class
    public func scaleStartPoint() -> CGPoint? {
        return startPoint
    }

    @objc func handleDismissPan(gesture: UIPanGestureRecognizer) {
        if startPoint == nil {
            startPoint = gesture.location(in: nil)
        }
        scaleForPanGuesture(gesture: gesture)
    }

    public func scaleWillBegin(gesture: UIPanGestureRecognizer, progress: CGFloat) {

    }

    public func scaleWillEnd(gesture: UIPanGestureRecognizer) {
        isScaleAnimationEnable = false
        startPoint = nil
    }

    public func scaleToDissmiss(gesture: UIPanGestureRecognizer) {
        scaleWillEnd(gesture: gesture)
    }

    public func scaleToDismissTrigger() -> CGFloat? {
        return 1.0
    }
}

extension UIScaleViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
