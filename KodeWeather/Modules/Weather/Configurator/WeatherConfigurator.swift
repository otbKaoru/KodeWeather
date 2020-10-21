//
//  WeatherConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class WeatherConfigurator {

    func configure() -> WeatherViewController {

        let viewController = WeatherViewController()

        let presenter = WeatherPresenter()

        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}

