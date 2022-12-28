//
//  Utility.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

// MARK: - GCD
public func getMainQueue(completion: @escaping (() -> Void)) {
    if Thread.isMainThread {
        completion()
    } else {
        DispatchQueue.main.async {
            completion()
        }
    }
}

public func getDelayMainQueue(delay: Double, completion: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        completion()
    }
}

public func getBackgroundQueue(qos: DispatchQoS.QoSClass = DispatchQoS.QoSClass.background,
                               completion: @escaping (() -> Void)) {
    DispatchQueue.global(qos: qos).async {
        completion()
    }
}

public var idGenerator: String {
    return "\(Int64(Date().timeIntervalSince1970 * 1000))"
}
