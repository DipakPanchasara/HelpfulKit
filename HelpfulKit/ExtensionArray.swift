//
//  ExtensionArray.swift
//  DPFoundationExtensionKit
//
//  Created by Dipak Panchasara on 22/12/22.
//

import Foundation

/// Error that is thrown when there is an issue processing
/// in the array.
public enum ArrayError: Error {
    case indexOutOfBounds /// Array index out of bounds
}

/// Helper extensions for the array.
public extension Array {

    /// Safe way to get an element from an array.
    /// - Parameter index: The element index.
    /// - Returns: An element in the array, nil otherwise.
    subscript (safe index: Int) -> Element? {

        guard index >= 0 else { return nil }

        return Int(index) < count ? self[Int(index)] : nil
    }

    /// This method updates an element in the array.
    /// - Parameter newElement: Element to update.
    /// - Parameter atIndex: Element index to update.
    /// - Throws: ArrayError if the index is out of bounds.
    mutating func safeUpdate(_ newElement: Element, atIndex index: UInt) throws {
        self[Int(index)] = newElement
    }

    /// This method inserts an element in the array.
    /// - Parameter newElement: Element to update.
    /// - Parameter atIndex: Element index to update.
    /// - Throws: ArrayError if the index is out of bounds.
    mutating func safeInsert(_ newElement: Element, atIndex index: UInt) throws {
        insert(newElement, at: Int(index))
    }

    /// Returns the current array count.
    func getCount() -> UInt { return UInt(count) }

    /// Helper method to accumulate an array.
    /// - Parameter initial: Initial array
    /// - Parameter combine: Callback that combines the element.
    /// - Returns: The accumulated array.
    func accumulate<U>(_ initial: U, combine: (U, Element) -> U) -> [U] {
        var running = initial
        return self.map { next in
            running = combine(running, next)
            return running
        }
    }

    /// Splits the array in to chunks defined by
    /// size
    /// For example:
    /// let array = ["one", "two", "three"]
    /// let divided = array.divide(2)
    /// This return the following
    /// [["one, "two"], ["three"]]
    func divide(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            let end = Swift.min($0 + size, count)
            
            if end <= count {
                return Array(self[$0 ..< Swift.min($0 + size, count)])
            }
            
            return [self[$0]]
        }
    }
}

extension Array {
    /// Remove the given element from this array, by comparing pointer references.
    ///
    /// - parameter element: The element to remove.
    public mutating func removeElementByReference(_ element: Element) {
        let objIndex = firstIndex {
            return $0 as AnyObject === element as AnyObject
        }
        
        if let objIndex = objIndex {
            remove(at: objIndex)
        }
    }
}

/// Swiping helper.
extension Array where Element : Equatable {

    /// This method swipes an element to the other element.
    /// element <- with
    public mutating func swipe(_ element: Iterator.Element?, with: Iterator.Element?) -> Bool {

        guard let element = element as Iterator.Element? else { return false }
        guard let with = with as Iterator.Element? else { return false }
        guard let index = self.firstIndex(of: element) as Int? else { return false }
        self[index] = with
        return true
    }
}

extension ArraySlice {

    /// Returns the array slice count.
    public func getCount() -> UInt { return UInt(count) }
}
