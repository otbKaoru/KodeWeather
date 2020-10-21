//
//  SearchConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class SearchConfigurator {

    func configure() -> SearchViewController {

        let viewController = SearchViewController()

        let presenter = SearchPresenter()

        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}
