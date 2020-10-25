//
//  AttractionsRouter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

class AttractionsRouter {
    weak var viewController: AttractionsViewController?
    let attractionDetailConfigurator = AttractionDetailConfigurator()
}

extension AttractionsRouter: AttractionsRouterInput {
    func showAttractionDetailModule(for attraction: Attraction) {
        viewController?.navigationController?.pushViewController(attractionDetailConfigurator.configure(with: attraction), animated: true)
    }
}
