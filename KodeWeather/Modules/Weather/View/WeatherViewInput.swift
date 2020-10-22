//
//  WeatherViewInput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//
import Foundation

protocol WeatherViewInput: class {
    func reloadCollectionViewData()
    func setLocationName(name: String)
    func setForecastViewDate(date: Date, forecast: ForecastType)
    func configureMap(location: Location) 
}
