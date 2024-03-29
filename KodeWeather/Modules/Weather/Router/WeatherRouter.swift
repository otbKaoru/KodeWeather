//
//  WeatherRouter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

class WeatherRouter {
    weak var viewController: WeatherViewController?
    var configurator = AttractionsConfigurator()

}

extension WeatherRouter: WeatherRouterInput {
    func showAttractionsModule(for location: Location) {
        viewController?.navigationController?.pushViewController(configurator.configure(with: location), animated: true)
    }

    func showError() {
        viewController?.navigationItem.searchController?.searchBar.endEditing(true)
        viewController?.navigationController?.pushViewController(ErrorViewController(), animated: true)

    }
}
