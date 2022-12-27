//
//  ExtensionCALayer.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public extension CALayer {

    func applySketchShadow(
        color: UIColor? = .black,
        alpha: Float = 0.16,
        xcoord: CGFloat = 0,
        ycoord: CGFloat = 3,
        blur: CGFloat = 6,
        spread: CGFloat = 0,
        applyBezier: Bool = true
    ) {
        masksToBounds = false
        shadowColor = color?.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xcoord, height: ycoord)
        shadowRadius = blur / 2.0
        guard spread != -1, applyBezier else { return }
        if spread == 0 {
            shadowPath = nil
        } else {
            shadowPath = UIBezierPath(
                rect: bounds.insetBy(dx: -spread, dy: -spread)
            ).cgPath
        }
    }
}
