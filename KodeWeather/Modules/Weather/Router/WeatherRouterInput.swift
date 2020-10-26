//
//  WeatherRouterInput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

protocol WeatherRouterInput {
    func showAttractionsModule(for location: Location)
    func showError()
}
