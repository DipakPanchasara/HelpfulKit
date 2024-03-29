//
//  ExtensionNSObject.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public extension NSObject {

    @objc class var className: String {
        String(describing: self)
    }

    var className: String {
        String(describing: type(of: self))
    }

    class var bundle: Bundle {
        Bundle(for: self)
    }

    @objc func isUnitTestRunning() -> Bool {
        if NSClassFromString("XCTest") != nil {
            print("\(#function) METHOD CALLED FROM UNIT TEST")
            return true
        }
        return false
    }
}
