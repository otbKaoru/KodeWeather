//
//  WeatherViewOutput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Foundation

protocol WeatherViewOutput {
    func viewLoaded()
    func cellViewModel(for indexPath: IndexPath, forecast: ForecastType) -> WeatherCellViewModel?
    func numberOfRows(forecast: ForecastType) -> Int
    func attractionsButtonTapped()
}
