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
        let text = viewController?.navigationItem.searchController?.searchBar.text
        viewController?.navigationController?.pushViewController(weatherConfigurator.configure(with: location), animated: true)
        viewController?.navigationItem.searchController?.searchBar.endEditing(true)
        viewController?.navigationItem.searchController?.isActive = false
        viewController?.navigationItem.searchController?.searchBar.text = text
    }

    func showError() {
        viewController?.navigationItem.searchController?.searchBar.endEditing(true)
        viewController?.navigationController?.pushViewController(ErrorViewController(), animated: true)
    }
}
