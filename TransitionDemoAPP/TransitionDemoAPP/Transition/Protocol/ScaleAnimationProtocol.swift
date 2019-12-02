//
//  ScaleAnimationProtocol.swift
//  AppStoreDemo
//
//  Created by 汤军 on 2019/11/14.
//  Copyright © 2019 Utimes. All rights reserved.
//

import UIKit

//ScaleAnimation works on Pan guesture which should be aimplied in a view or controller's view
public protocol ScaleAnimationProtocol {

    /// is scale enable
    var isScaleAnimationEnable: Bool { get set }


    /// determin wether to call scaleToDissmiss method when pull to scaleToDismissTrigger point
    var isScaleToDissmissEnable: Bool { get set }


    /// the point where to start the interactive、you must return the start point of your gesture before you call the scaleForPanGuesture method
    func scaleStartPoint() -> CGPoint?


    /// the pull distance ratio to trigger a dismiss action, default is 1.0
    func scaleToDismissTrigger() -> CGFloat?


    /// called when UIPanGestureRecognizer.state began and changed
    /// - Parameter gesture: UIPanGestureRecognizer
    /// - Parameter progress: the pull distance ratio
    func scaleWillBegin(gesture: UIPanGestureRecognizer, progress: CGFloat)


    /// called when UIPanGestureRecognizer.state ended or triggered right away after scaleToDissmiss is called
    /// - Parameter gesture: UIPanGestureRecognizer
    func scaleWillEnd(gesture: UIPanGestureRecognizer)


    /// call scaleToDissmiss method when pull to scaleToDismissTrigger point
    /// - Parameter gesture: UIPanGestureRecognizer
    func scaleToDissmiss(gesture: UIPanGestureRecognizer)

    /// deal with the change of UIPanGestureRecognizer
    /// - Parameter gesture: UIPanGestureRecognizer
    func scaleForPanGuesture(gesture: UIPanGestureRecognizer)
}


extension ScaleAnimationProtocol where Self: UIViewController {

    
    
    public func scaleForPanGuesture(gesture: UIPanGestureRecognizer) {

        if !isScaleAnimationEnable { return }

        guard let startingPoint = scaleStartPoint() else { return }
        let currentLocation = gesture.location(in: nil)

        var progress = (currentLocation.y - startingPoint.y) / 100

        if currentLocation.y <= startingPoint.y { progress = 0 }

        let triggerRation = scaleToDismissTrigger() ?? 1.0
        if isScaleToDissmissEnable && progress >= triggerRation {
            UIView.animate(withDuration: 0.2) {
                gesture.view?.transform = CGAffineTransform.identity
            }
            scaleToDissmiss(gesture: gesture)
            return
        }

        let targetShrinkScale: CGFloat = 0.86
        let currentScale: CGFloat = 1 - (1 - targetShrinkScale) * progress

        switch gesture.state {
        case .began,.changed:
            gesture.view?.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
            scaleWillBegin(gesture: gesture, progress: progress)
        case .cancelled,.ended:
            UIView.animate(withDuration: 0.2) {
                gesture.view?.transform = CGAffineTransform.identity
            }
            scaleWillEnd(gesture: gesture)
        default:
            break
        }
    }
}
