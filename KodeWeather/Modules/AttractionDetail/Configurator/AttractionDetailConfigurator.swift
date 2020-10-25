//
//  AttractionDetailConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

final class AttractionDetailConfigurator {

    func configure(with input: Attraction?) -> AttractionDetailViewController {

        let viewController = AttractionDetailViewController()

        let presenter = AttractionDetailPresenter()
        let router = AttractionDetailRouter()

        router.viewController = viewController

        presenter.router = router
        presenter.view = viewController
        presenter.attraction = input
        viewController.output = presenter

        return viewController
    }
}

