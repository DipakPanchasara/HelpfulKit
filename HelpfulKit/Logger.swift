//
//  Logger.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 22/12/22.
//

import Foundation

import os.log

public enum LoggerLevel {
    case error, warn, info, debug, console
}

/// This protocol represents a Tracker
/// object that is use to measure performance
public protocol PerformanceTracker {

    /// Name of the particular tracker
    init(name: String)
    
    /// Stop's tracking
    func stop()
}

/// This protocol is used for specific implementation
/// of a solution to track performance.
public protocol PerformanceTrackingSolution {
    
    /// Generates a tracking event.
    func start(name: String) -> PerformanceTracker
}

/**
 This class is used as the entry point to measure performance.

 For example if we wan't to measure a particular performance on a
 method the following would be the usage. This values will be available
 in the Performance solution registered into this class.
 
 ````
 func process() {
 let tracker = CorePerformance.sharedInstance.start(name: "processTracker")
 
   ....
 
 tracker.stop()
 }
 
 ````
 */
public class CorePerformance {
    
    private var tracker: PerformanceTrackingSolution?
    
    public class var sharedInstance: CorePerformance {
        
        struct CorePerformanceInstance {
            
            static let instance = CorePerformance()
        }
        
        return CorePerformanceInstance.instance
    }
    
    /// Way to register a particular performance tracker
    public func registerTracker(tracker: PerformanceTrackingSolution) {
        self.tracker = tracker
    }
    
    /// Entry point to generate a new performance trakcer
    public func start(name: String) -> PerformanceTracker? {
        return tracker?.start(name: name)
    }
}

/// Protocol that is use as a way to create a custom
/// logger for the application.
public protocol CustomLogger {
    
    var currentLevel: LoggerLevel { get set }
    
    func log(level: LoggerLevel, text: String)
    
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "-"

    static let viewCycle = OSLog(subsystem: subsystem, category: "HelpfulKit")
}

@objc
public final class Logger: NSObject {

    private static var customLoggers = [CustomLogger]()
    
    public init(level: LoggerLevel = .error,
                customLoggers: [CustomLogger] = [CustomLogger]()) {
        super.init()
        Logger.customLoggers = customLoggers
        setupLoggers(level: level)
    }

    // swiftlint:disable identifier_name
    @objc
    public static func Error(_ text: String,
                             fileName: String = #file,
                             functionName: String = #function,
                             lineNumber: Int = #line) {
        log(text,
            level: .error,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
        Logger.notifyCustomLoggers(level: .error, text: text)
    }

    // swiftlint:disable identifier_name
    public static func Warn(_ text: String,
                            fileName: String = #file,
                            functionName: String = #function,
                            lineNumber: Int = #line) {
        log(text,
            level: .warn,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
        Logger.notifyCustomLoggers(level: .warn, text: text)
    }

    // swiftlint:disable identifier_name
    public static func Info(_ text: String,
                            fileName: String = #file,
                            functionName: String = #function,
                            lineNumber: Int = #line) {
        log(text,
            level: .info,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
        Logger.notifyCustomLoggers(level: .info, text: text)
    }

    // swiftlint:disable identifier_name
    public static func Debug(_ text: String,
                             fileName: String = #file,
                             functionName: String = #function,
                             lineNumber: Int = #line) {
        log(text,
            level: .debug,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
        Logger.notifyCustomLoggers(level: .debug, text: text)
    }

    // swiftlint:disable identifier_name
    public static func Console(_ text: String,
                               fileName: String = #file,
                               functionName: String = #function,
                               lineNumber: Int = #line) {
        log(text,
            level: .debug,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber) // setting as debug, since console -> debug
        Logger.notifyCustomLoggers(level: .console, text: text)
    }

    private static func log(_ text: String,
                            level: LoggerLevel,
                            fileName: String = #file,
                            functionName: String = #function,
                            lineNumber: Int = #line) {

        var osLogLevel: OSLogType = .default

        switch level {
        case.console: osLogLevel = .debug
        case.debug: osLogLevel = .debug
        case.error: osLogLevel = .error
        case.info: osLogLevel = .info
        case.warn: osLogLevel = .fault
        }

        os_log("[%@ %@] %@",
               log: OSLog.viewCycle,
               type: osLogLevel,
               fileName,
               functionName,
               text)
    }

    private func setupLoggers(level: LoggerLevel) {

        // set the current level
        for var logger in Logger.customLoggers {
            logger.currentLevel = level
        }
    }

    private static func notifyCustomLoggers(level: LoggerLevel, text: String) {
        guard !Logger.customLoggers.isEmpty else { return }
        
        for logger in Logger.customLoggers {
            logger.log(level: level, text: text)
        }
    }
}
