//
//  ExtensionDictionary.swift
//  DPFoundationExtensionKit
//
//  Created by Dipak Panchasara on 22/12/22.
//

import Foundation

public struct KeyPath {
    var segments: [String]

    var isEmpty: Bool { return segments.isEmpty }
    var path: String {
        return segments.joined(separator: ".")
    }

    /// Strips off the first segment and returns a pair
    /// consisting of the first segment and the remaining key path.
    /// Returns nil if the key path has no segments.
    func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
}

/// Initializes a KeyPath with a string of the form "this.is.a.keypath"
extension KeyPath {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}

extension KeyPath: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

public protocol DictionaryStringProtocol {
    // swiftlint:disable identifier_name
    init(string s: String)
}

extension String: DictionaryStringProtocol {
    // swiftlint:disable identifier_name
    public init(string s: String) {
        self = s
    }
}

public extension Dictionary {

    /// Merges a dictionary.
    /// - Parameter dictionary: Dictionary to merge it's values
    /// - Returns: Dictionary merged dictionary
    func union (_ dictionary: Dictionary) -> Dictionary {

        var result = self

        dictionary.forEach { (key, value) -> Void in
            _ = result.updateValue(value, forKey: key)
        }

        return result

    }

    /// Merges a list of dictionaries.
    /// - Parameter dictionaries: Dictionaries to merge it's values
    /// - Returns: Dictionary merged dictionary
    func union (_ dictionaries: [Dictionary]) -> Dictionary {

        var result = self

        dictionaries.forEach { (dictionary) -> Void in
            dictionary.forEach { (key, value) -> Void in
                _ = result.updateValue(value, forKey: key)
            }
        }

        return result

    }
}

public extension Dictionary where Key: DictionaryStringProtocol {
     subscript(keyPath keyPath: KeyPath) -> Any? {
        switch keyPath.headAndTail() {
        case nil:
            // key path is empty.
            return nil
        case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
            // Reached the end of the key path.
            let key = Key(string: head)
            return self[key]
        case let (head, remainingKeyPath)?:
            // Key path has a tail we need to traverse.
            let key = Key(string: head)
            switch self[key] {
            case let nestedDict as [Key: Any]:
                // Next nest level is a dictionary.
                // Start over with remaining key path.
                return nestedDict[keyPath: remainingKeyPath]
            default:
                // Next nest level isn't a dictionary.
                // Invalid key path, abort.
                return nil
            }
        }
    }
}

public func | <K, V> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.union(second)
}

public extension Dictionary {

     static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
}

public extension Dictionary {

    var getKeyValueString: String {
        var arr = [String]()
        for (key, value) in self {
            arr.append("\(key)=\(value)")
        }
        return arr.joined(separator: "&")
    }
    var data: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)

    }
}
