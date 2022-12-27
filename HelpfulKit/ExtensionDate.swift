//
//  ExtensionDate.swift
//  HelpfulKit
//
//  Created by Dipak Panchasara on 27/12/22.
//

import Foundation

extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        return self.toTime(isGlobalOrLocal: true)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        return self.toTime(isGlobalOrLocal: false)
    }
    
    func toTime(isGlobalOrLocal: Bool) -> Date {
        let timezone = TimeZone.current
        let seconds = isGlobalOrLocal ? -TimeInterval(timezone.secondsFromGMT(for: self)) : TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func removeTimeStamp() -> Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
        return date ?? self
    }
    func weekOfYear() -> Int {
        let weekOfYear = Calendar.current.component(.weekOfYear, from: self)
        return weekOfYear
    }
    
    public var dayofTheWeek: String {
        let dayNumber = Calendar.current.component(.weekday, from: self)
        // day number starts from 1 but array count from 0
        return daysOfTheWeek[dayNumber - 1]
    }
    
    var dayOfMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var monthStringMMMM: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var graphXAxisDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: self)
    }
    
    var entryDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    var fullEntryDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var quarterDisplayStartDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
    
    var stringOnMMddyyyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    
    var quarterDisplayEndDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
    var readableDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func totalNumberOfDays(endDate: Date) -> Int {
        Calendar.current.dateComponents([.day], from: self, to: endDate).day ?? 0
    }
    
    func totalNumberOfWeeks(endDate: Date) -> Int {
        let totalWeeks = Calendar.current.dateComponents([.weekOfMonth], from: self, to: endDate).weekOfMonth
        return totalWeeks ?? 0
    }
    
    func totalNumberOfMonths(endDate: Date) -> Int {
        let totalWeeks = Calendar.current.dateComponents([.month], from: self, to: endDate).month
        return totalWeeks ?? 0
    }
    
    var graphDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .dateFormat.DateFormat_yyyy_MM_dd_Txt
        return dateFormatter.string(from: self)
    }
    
    var monthOfDateInInt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .dateFormat.DateFormat_MM_Txt
        return dateFormatter.string(from: self)
    }
    
    internal var daysOfTheWeek: [String] {
        return  ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.dayBefore.compare(self) == self.compare(date2.tommorrow)
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    var string: String {
        "\(self)"
    }
    
    func formatted(with dateFormatter: DateFormatter) -> String {
        dateFormatter.string(from: self)
    }
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
extension TimeInterval {
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}
extension String {
    struct dateFormat {
        //Date formatter types
        static let DateFormat_MM_Txt = "MM"
        static let DateFormat_HH_Txt = "HH"
        static let DateFormat_yyyy_MM_dd_Txt = "yyyy-MM-dd"
        static let MonthDateYearFormat_TypeI  = "mm/dd/yyyy"
        static let MonthDateYearFormat_TypeII  = "MM/dd/yyyy"
        static let MonthDateYearFormat_TypeIII = "yyyy-MM-dd"
        static let DateFormat_Sweepstakes_TypeI  = "yyyy-MM-dd'T'HH:mm:ss"
        static let Messaging_DateTimeTypeFormat_Txt = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        static let DateFormat_Day_TypeI = "E, d MMM yyyy HH:mm:ss"
        static let DateFormat_Day_TypeII = "h:mm a EEEE, MMMM d, yyyy"
        static let DateFormat_Day_TypeIII = "h:mm a MM/dd/yyyy"
        static let DateFormat_TypeIV  = "MM/dd/yyyy hh:mm a"
        static let DateFormat_Date = "MMM d, yyyy h:mm a"
    }
}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var twoDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var threeDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var fourDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var twoHoursAgo: Date {
        return Calendar.current.date(byAdding: .hour, value: -2, to: noon)!
    }
    var fiveHoursAgo: Date {
        return Calendar.current.date(byAdding: .hour, value: -5, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tommorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
   
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
