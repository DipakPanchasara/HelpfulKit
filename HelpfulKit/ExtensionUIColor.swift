//
//  ExtensionUIColor.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit
public extension UIColor {
    /// Initializer for creating color
    ///
    /// - parameter red: red color component value ranges
    ///   from 0 to 255 or hex code of red component value rages from 0x01 to 0xFF.
    /// - parameter green: green color component value ranges
    ///   from 0 to 255 or hex code of green component value rages from 0x01 to 0xFF.
    /// - parameter blue: blue color component value ranges
    ///   from 0 to 255 or hex code of blue component value rages from 0x01 to 0xFF.
    /// - parameter alpha: is optional to indicate alpha of color value ranges
    ///   from 0 to 1.0.
    /// - returns: UIColor
    ///
    /// # Example #
    /// ```
    /// let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, alpha: 0.5)
    /// let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    /// let color2 = UIColor(rgb: 0xFFFFFF, alpha: 0.5)
    /// ```
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    /// Initializer for creating color
    ///
    /// - parameter rgb: hex code of color component value rages from 0x000000 to 0xFFFFFF.
    /// - parameter alpha: is optional to indicate alpha of color value ranges from 0 to 1.0.
    /// - returns: UIColor
    ///
    /// # Example #
    /// ```
    /// let color2 = UIColor(rgb: 0xFFFFFF, alpha: 0.5)
    /// let color = UIColor(rgb: 0xFFFFFF)
    /// ```
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
    /// Initializer for creating color from hex string
    ///
    /// - parameter hexStringToUIColor: hex code of color component value rages from "#000000" to "#FFFFFF".
    /// - parameter alpha: is optional to indicate alpha of color value ranges from 0 to 1.0.
    /// - returns: UIColor
    ///
    /// # Example #
    /// ```
    /// let color2 = UIColor(hexStringToUIColor: "#FFFFFF", alpha: 0.5)
    /// let color = UIColor(hexStringToUIColor: "#FFFFFF")
    /// ``
    convenience init(hexStringToUIColor: String, alpha: CGFloat = 1.0) {
        var cString: String = hexStringToUIColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            self.init(
                red: 128.0,
                green: 128.0,
                blue: 128.0,
                alpha: alpha
            )
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public extension UIColor {
    /// Inverse color from UIColor
    ///
    /// - returns: UIColor
    ///
    /// # Example #
    /// ```
    /// let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, alpha: 0.5).inverse()
    ///
    /// ```
    func inverse() -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }
        return .black // Return a default colour
    }
}

public extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            self.init(cgColor: UIColor.gray.cgColor)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return String(format: "#%06x", rgb)
    }
}
