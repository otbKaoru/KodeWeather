//
//  ForecastType.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 22.10.2020.
//

enum ForecastType: Int, CaseIterable {
    case today
    case tomorrow

    var localization: String {
        switch self {
        case .today:
            return Localization.Weather.todayForecast
        case .tomorrow:
            return Localization.Weather.tomorrowForecast
        }
    }
}
