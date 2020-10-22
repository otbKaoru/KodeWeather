//
//  Date+Day.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 22.10.2020.
//

import Foundation

extension Date {
    func day() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
}
