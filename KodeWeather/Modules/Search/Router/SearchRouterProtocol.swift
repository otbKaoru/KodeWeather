//
//  SearchRouterProtocol.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

protocol SearchRouterProtocol: class {
    func openWeatherModule(for location: Location)
}