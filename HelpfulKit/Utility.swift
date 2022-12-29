//
//  Utility.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public var idGenerator: String {
    return "\(Int64(Date().timeIntervalSince1970 * 1000))"
}

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

// MARK: -

/// Remove null object from Dictonary
/// - Parameter source: Dictonary contained null value
/// - Returns: Dictonary contained not null value
public func rejectNil(_ source: [String: Any?]) -> [String: Any]? {
    let destination = source.reduce(into: [String: Any]()) { (result, item) in
        if let value = item.value {
            result[item.key] = value
        }
    }
    if destination.isEmpty {
        return nil
    }
    return destination
}

// swiftlint:disable syntactic_sugar
/// Remove null object from API Header
/// - Parameter source: Dictonary contained null value
/// - Returns: Dictonary contained not null Headers
public func rejectNilHeaders(_ source: [String: Any?]) -> [String: String] {
    return source.reduce(into: [String: String]()) { (result, item) in
        if let collection = item.value as? Array<Any?> {
            result[item.key] = collection.filter({ $0 != nil }).map { "\($0!)" }.joined(separator: ",")
        } else if let value: Any = item.value {
            result[item.key] = "\(value)"
        }
    }
}

/// Convert Bool To String
/// - Parameter source: Dictonary contained Bool value
/// - Returns: Dictonary contained Bool value To String
///
public func convertBoolToString(_ source: [String: Any]?) -> [String: Any]? {
    guard let source = source else {
        return nil
    }
    return source.reduce(into: [String: Any](), { (result, item) in
        switch item.value {
        case let xBool as Bool:
            result[item.key] = xBool.description
        default:
            result[item.key] = item.value
        }
    })
}

/// Convert Dictonary Values To Query Items
/// - Parameter source: Dictonary
/// - Returns: Array of URLQueryItems
///
public func mapValuesToQueryItems(_ source: [String: Any?]) -> [URLQueryItem]? {
    let destination = source.filter({ $0.value != nil}).reduce(into: [URLQueryItem]()) { (result, item) in
        if let collection = item.value as? Array<Any?> {
            let value = collection.filter({ $0 != nil }).map({"\($0!)"}).joined(separator: ",")
            result.append(URLQueryItem(name: item.key, value: value))
        } else if let value = item.value {
            result.append(URLQueryItem(name: item.key, value: "\(value)"))
        }
    }
    if destination.isEmpty {
        return nil
    }
    return destination
}
