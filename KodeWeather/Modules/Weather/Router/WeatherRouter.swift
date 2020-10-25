//
//  WeatherRouter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

class WeatherRouter {
    weak var viewController: WeatherViewController?
    var attractionsConfigurator = AttractionsConfigurator()

}

extension WeatherRouter: WeatherRouterInput {
    func showAttractionsModule(for location: Location) {
        viewController?.navigationController?.pushViewController(attractionsConfigurator.configure(with: location), animated: true)
    }
}
