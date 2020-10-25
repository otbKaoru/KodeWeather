//
//  AttractionsConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

final class AttractionsConfigurator {

    func configure(with input: Location? = nil) -> AttractionsViewController {

        let viewController = AttractionsViewController()

        let presenter = AttractionsPresenter()
        let router = AttractionsRouter()

        presenter.view = viewController
        
        presenter.locationName = input?.name
        presenter.router = router

        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}

