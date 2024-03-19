//
//  ExtensionUIView.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

@IBDesignable public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            // If masksToBounds is true, subviews will be
            // clipped to the rounded corners.
            layer.masksToBounds = (newValue > 0)
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    var isVisible: Bool {
        (self.window != nil)
    }
}

public extension UIView {
    /**
     Returns a view from a nib (with the same name)
     */
     class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        let bundle = Bundle(for: self)
        guard
            let nib = bundle.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }

    /**
     See: https://stackoverflow.com/questions/30696307/how-to-convert-a-uiview-to-an-image
     */
    func renderedToUIImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    /**
     Loads a nib file with the same name as the generic view type `T` and returns
     the first view found in the nib file with matching type `T`. For example, if
     the generic type is `MyView`, a nib file named `MyView.nib` is loaded and the
     first top-level view of type `MyView` is returned. The main bundle is searched
     first followed by the SwiftMessages bundle.
     
     - Parameter filesOwner: An optional files owner.
     
     - Throws: `Error.CannotLoadViewFromNib` if a view matching the
       generic type `T` is not found in the nib.
     
     - Returns: An instance of generic view type `T`.
     */
    class func viewFromNib<T: UIView>(_ filesOwner: AnyObject = NSNull.init()) throws -> T {
        let name = T.description().components(separatedBy: ".").last
        assert(name != nil)
        let view: T = try internalViewFromNib(named: name!, bundle: nil, filesOwner: filesOwner)
        return view
    }
    
    /**
     Loads a nib file with specified name and returns the first view found in the  nib file
     with matching type `T`. The main bundle is searched first followed by the SwiftMessages bundle.
     
     - Parameter name: The name of the nib file (excluding the .xib extension).
     - Parameter filesOwner: An optional files owner.
     
     - Throws: `Error.CannotLoadViewFromNib` if a view matching the
     generic type `T` is not found in the nib.
     
     - Returns: An instance of generic view type `T`.
     */
    class func viewFromNib<T: UIView>(named name: String, filesOwner: AnyObject = NSNull.init()) throws -> T {
        let view: T = try internalViewFromNib(named: name, bundle: nil, filesOwner: filesOwner)
        return view
    }
    
    /**
     Loads a nib file with specified name in the specified bundle and returns the
     first view found in the  nib file with matching type `T`.
     
     - Parameter name: The name of the nib file (excluding the .xib extension).
     - Parameter bundle: The name of the bundle containing the nib file.
     - Parameter filesOwner: An optional files owner.
     
     - Throws: `Error.CannotLoadViewFromNib` if a view matching the
     generic type `T` is not found in the nib.
     
     - Returns: An instance of generic view type `T`.
     */
    class func viewFromNib<T: UIView>(named name: String, bundle: Bundle, filesOwner: AnyObject = NSNull.init()) throws -> T {
        let view: T = try internalViewFromNib(named: name, bundle: bundle, filesOwner: filesOwner)
        return view
    }
    
    fileprivate class func internalViewFromNib<T: UIView>(named name: String, bundle: Bundle? = nil, filesOwner: AnyObject = NSNull.init()) throws -> T {
        let resolvedBundle: Bundle
        if let bundle = bundle {
            resolvedBundle = bundle
        } else {
            if Bundle.main.path(forResource: name, ofType: "nib") != nil {
                resolvedBundle = Bundle.main
            } else {
                resolvedBundle = Bundle.helpfulkit_frameworkBundle()
            }
        }
        let arrayOfViews = resolvedBundle.loadNibNamed(name, owner: filesOwner, options: nil) ?? []
        #if swift(>=4.1)
        guard let view = arrayOfViews.compactMap( { $0 as? T} ).first else { throw HelpfulKitError.cannotLoadViewFromNib(nibName: name) }
        #else
        guard let view = arrayOfViews.flatMap( { $0 as? T} ).first else { throw SwiftMessagesError.cannotLoadViewFromNib(nibName: name) }
        #endif
        return view
    }
}
