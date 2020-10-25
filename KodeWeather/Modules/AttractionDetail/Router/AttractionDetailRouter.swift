//
//  AttractionDetailRouter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

class AttractionDetailRouter {
    weak var viewController: AttractionDetailViewController?
}

extension AttractionDetailRouter: AttractionDetailRouterInput {
    func showFullMap(for location: Location) {
        viewController?.navigationController?.pushViewController(AttcartionDetailFullMapViewController(with: location), animated: true)
    }

}
