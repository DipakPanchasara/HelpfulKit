//
//  ExtensionUIViewController.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit
import SafariServices

public extension UIViewController {
    func hideNavigationBar(animated: Bool) {
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

public extension UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   titleAttributedString: NSAttributedString? = nil,
                   preferredStyle: UIAlertController.Style = UIAlertController.Style.alert,
                   alertAction: UIAlertAction ...) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let attributedString = titleAttributedString {
          alertController.setValue(attributedString, forKey: "attributedTitle")
        }
        for action in alertAction {
            alertController.addAction(action)
        }
        getMainQueue {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func openSafari(url: URL) {
        let svc = SFSafariViewController(url: url)
        svc.modalPresentationStyle = .overFullScreen
        self.present(svc, animated: true, completion: nil)
    }
}
