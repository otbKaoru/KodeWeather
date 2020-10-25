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
        
        presenter.locationName = input?.name

        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}

