//
//  ExtensionString.swift
//  DPFoundationExtensionKit
//
//  Created by Dipak Panchasara on 22/12/22.
//

import Foundation
import UIKit

extension String {

    /// Constructs an NSDate based on the following
    /// format: yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
    /// - Returns: NSDate when the string contains the valid format,
    ///            otherwise nil
    public func constructDate() -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        return dateFormatter.date(from: self)
    }

    /// This method converts a string representing a phone number to the correct format
    /// Valid Phone number types
    /// (733) 444-4444 -> +1 (733) 444-4444
    /// 18002324545 -> +1 (800) 232-4545
    /// Otherwise (ex "", "aaaa", "3333") will return an empty String
    /// - Returns: Formatted Phone number, otherwise an empty String
    public var prettyPrintPhoneNumber: String {

        let convertedPhoneNumber = NSMutableString(string: phoneNumber as NSString)
        let stringts: NSMutableString = convertedPhoneNumber

        guard convertedPhoneNumber.length >= 10 else { return "" }

        if convertedPhoneNumber.length == 11 {
            stringts.insert("+", at: 0)
            stringts.insert(" ", at: 2)
            stringts.insert("(", at: 3)
            stringts.insert(")", at: 7)
            stringts.insert(" ", at: 8)
            stringts.insert("-", at: 12)
        } else if convertedPhoneNumber.length == 10 {
            stringts.insert("+", at: 0)
            stringts.insert("1", at: 1)
            stringts.insert(" ", at: 2)
            stringts.insert("(", at: 3)
            stringts.insert(")", at: 7)
            stringts.insert(" ", at: 8)
            stringts.insert("-", at: 12)
        }

        return stringts as String
    }

    /// Converts the string into all numbers in a way that can be use for making a phone call
    public var phoneNumber: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }

    public var isSuccess: Bool {
        return self.caseInsensitiveCompare("success") == .orderedSame
    }

}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
}

extension StringProtocol {

    /// Checks if it has the string and lowercases both so capitalization is independent
    /// - Parameter other: string contained
    /// - Returns: true if it contains the string regardless of capitalization.
    func contains<T: StringProtocol>(other: T) -> Bool {
        lowercased().contains(other.lowercased())
    }

    /// Useful for search.
    /// - Parameter other: string contained
    /// - Returns: false if the string is not contained and not "" nor nil.
    func containsOrEmpty<T: StringProtocol>(other: T?) -> Bool {
        other.map { $0 == "" ? true : contains(other: $0) } ?? true
    }
}
