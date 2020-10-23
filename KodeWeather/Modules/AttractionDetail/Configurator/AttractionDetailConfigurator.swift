//
//  AttractionDetailConfigurator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

final class AttractionDetailConfigurator {

    func configure() -> AttractionDetailViewController {

        let viewController = AttractionDetailViewController()

        let presenter = AttractionDetailPresenter()

        presenter.view = viewController
        viewController.output = presenter

        return viewController
    }
}

