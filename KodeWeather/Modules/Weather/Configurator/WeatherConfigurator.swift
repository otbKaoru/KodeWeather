//
//  WeatherConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class WeatherConfigurator {

    func configure(with input: Location = Location(name: "", lan: 0, lon: 0)) -> WeatherViewController {

        let viewController = WeatherViewController()

        let presenter = WeatherPresenter()

        presenter.view = viewController
        presenter.location = input
        viewController.output = presenter

        return viewController
    }
}

