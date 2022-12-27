//
//  ExtensionUIApplication.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public extension UIApplication {
    
    class func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        var cont = controller
        if controller == nil {
            if #available(iOS 15, *) {
                cont = UIApplication.keyWindowScene?.rootViewController
            } else {
                cont = UIApplication.shared.windows.first?.rootViewController
            }
        }
        if let navigationController = cont as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = cont as? UITabBarController, let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
        if let presented = cont?.presentedViewController {
            return topViewController(controller: presented)
        }
        if let alert = cont as? UIAlertController {
            if let navigationController = alert.presentingViewController as? UINavigationController {
                return navigationController.viewControllers.last
            }
            return alert.presentingViewController
        }
        return controller
    }
}


@available(iOS 13.0, *)
public extension UIApplication {
    
    class var keyWindowScene: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}

