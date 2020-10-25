//
//  WeatherConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class WeatherConfigurator {

    func configure(with input: Location?) -> WeatherViewController {

        let viewController = WeatherViewController()

        let presenter = WeatherPresenter()
        let router = WeatherRouter()

        router.viewController = viewController

        presenter.view = viewController
        presenter.router = router
        presenter.location = input
        
        viewController.output = presenter

        return viewController
    }
}

