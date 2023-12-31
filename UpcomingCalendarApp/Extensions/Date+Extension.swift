

import Foundation

// this extension doesn't work, wrong date is shown up, i don't know why

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        var resultString = ""
        if years(from: date)   > 0 {resultString.append("\(years(from: date))y")}
        if months(from: date)  > 0 {resultString.append("\(months(from: date))M")}
        if days(from: date)    > 0 {resultString.append("\(days(from: date))d")}
        if hours(from: date)   > 0 {resultString.append("\(hours(from: date))h")}
        if minutes(from: date) > 0 {resultString.append("\(minutes(from: date))m") }
        else {
            resultString = "less than a min"
        }
        return resultString
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}

