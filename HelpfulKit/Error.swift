//
//  File.swift
//  
//
//  Created by Dipak Panchasara on 19/03/24.
//

import Foundation
/**
 The `HelpfulKit` enum contains the errors thrown by HelpfulKit.
 */
enum HelpfulKitError: Error {
    case cannotLoadViewFromNib(nibName: String)
    case noRootViewController
}
