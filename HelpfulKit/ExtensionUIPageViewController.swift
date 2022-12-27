//
//  ExtensionUIPageViewController.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit
public extension UIPageViewController {

    var scrollView: UIScrollView? {

        return view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
    }
}
