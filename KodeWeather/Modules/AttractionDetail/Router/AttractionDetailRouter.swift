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
    func showFullMap(lan: Double, lon: Double) {
        viewController?.navigationController?.pushViewController(AttcartionDetailFullMapViewController(lan: lan, lon: lon), animated: true)
    }

}
