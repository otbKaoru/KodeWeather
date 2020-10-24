//
//  WeatherModuleInput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

protocol WeatherModuleInput {
    var name: String { get }
    var lan: Double { get }
    var lon: Double { get }
}
