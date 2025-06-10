//
//  Date+Extensions.swift
//  SharedExtensions
//
//  Created by Nikita Shvad on 15.11.2023.
//

import Foundation

public extension Date {
    func timeIntervalSinceStartOfDay(in calendar: Calendar = Calendar.current) -> TimeInterval {
        let midnight = calendar.startOfDay(for: self)
        let timeInterval = timeIntervalSince(midnight)
        return timeInterval
    }
}
