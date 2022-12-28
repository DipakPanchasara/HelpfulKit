//
//  ExtensionUIWindow.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public extension UIWindow {
    // swiftlint:disable nesting
    /// Transition Options
    class TransitionOptions: NSObject, CAAnimationDelegate {
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let key: String!
                switch self {
                case .linear: key = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.linear)
                case .easeIn: key = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
                case .easeOut: key = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeOut)
                case .easeInOut: key = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeInEaseOut)
                }
                return CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(key))
            }
        }
        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            /// Return the associated transition
            ///
            /// - Returns: transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }
        /// Background of the transition
        /// - snapshot: snapshot of current root view controller
        /// - solidColor: solid color
        /// - customView: custom view
        public enum Background {
            case snapshot
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20
        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight
        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background?
        public var completionBlock: ((Bool) -> Void)?
        weak var previousViewController: UIViewController?
        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            transition.delegate = self
            return transition
        }
        public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            let oldNavigationController = previousViewController as? UINavigationController
            oldNavigationController?.viewControllers = []
            // This is a tempoarary hack - not sure why nav controllers arent freed up.
            completionBlock?(flag)
        }
    }
    /// Fix for http://stackoverflow.com/a/27153956/849645
    func set(rootViewController newRootViewController: UIViewController,
             options: TransitionOptions = TransitionOptions(),
             _ completion: ((Bool) -> Void)? = nil) {
        let previousViewController = rootViewController
        layer.add(options.animation, forKey: kCATransition)
        options.completionBlock = completion
        options.previousViewController = rootViewController
        rootViewController = newRootViewController
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        if #unavailable(iOS 13.0) {
            //            The presenting view controllers view doesn't get removed from
            //            the window as its currently transistioning and presenting a view controller
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}
// Helper function inserted by Swift 4.2 migrator.
private func convertFromCAMediaTimingFunctionName(_ input: CAMediaTimingFunctionName) -> String {
    return input.rawValue
}
// Helper function inserted by Swift 4.2 migrator.
private func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
    return CAMediaTimingFunctionName(rawValue: input)
}
