//
//  ExtensionSequence.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation

public extension Sequence where Element: StringProtocol {
    func searched(text: String?) -> [Element] {
        filter { $0.containsOrEmpty(other: text) }
    }
}

public extension Sequence where Element: CustomStringConvertible {
    func searched(text: String?) -> [Element] {
        filter { $0.description.containsOrEmpty(other: text) }
    }
}

public extension Sequence {
    var array: [Element] {
        Array(self)
    }
}
