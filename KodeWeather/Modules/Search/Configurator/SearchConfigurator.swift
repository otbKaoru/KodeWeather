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
        let router = SearchRouter()
        router.viewController = viewController
        presenter.router = router

        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}
