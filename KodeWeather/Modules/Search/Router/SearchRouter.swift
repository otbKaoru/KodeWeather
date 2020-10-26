//
//  SearchRouter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

class SearchRouter {
    weak var viewController: SearchViewController?
    private let weatherConfigurator = WeatherConfigurator()
}

extension SearchRouter: SearchRouterInput {
    func showWeatherModule(for location: Location) {
        //viewController?.navigationController?.pushViewController(weatherConfigurator.configure(with: location), animated: true)
        viewController?.navigationController?.present(ErrorViewController(), animated: true, completion: nil)
    }
}
