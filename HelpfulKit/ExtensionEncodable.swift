//
//  ExtensionEncodable.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation
import UIKit

public extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data,
                                                  options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    var asData: Data? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return data
    }
}
