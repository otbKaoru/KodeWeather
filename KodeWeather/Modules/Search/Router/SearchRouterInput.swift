//
//  SearchRouterProtocol.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

protocol SearchRouterInput: class {
    func showWeatherModule(for location: Location)
    func showError()
}
