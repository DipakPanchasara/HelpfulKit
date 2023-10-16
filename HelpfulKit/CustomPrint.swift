//
//  CustomPrint.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 16/10/23.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let logs = OSLog(subsystem: subsystem, category: "Log")
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
//        Swift.print(output, terminator: terminator)
    os_log("%{private}@", log: OSLog.logs, type: .info, output)
    #endif
}
