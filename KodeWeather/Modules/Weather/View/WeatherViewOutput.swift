//
//  WeatherViewOutput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Foundation

protocol WeatherViewOutput {
    func viewLoaded()
    func todayCellViewModel(for indexPath: IndexPath) -> WeatherCellViewModel?
    func tomorrowCellViewModel(for indexPath: IndexPath) -> WeatherCellViewModel?
}
