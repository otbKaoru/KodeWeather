//
//  AttractionDetailPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation
import CoreData

final class AttractionDetailPresenter {

    // MARK: - Properties

    weak var view: AttractionDetailViewInput?

    private let attractionService: AttractionService = AttractionService()
}

extension AttractionDetailPresenter: AttractionDetailViewOutput {
    func viewLoaded() {
        print(attractionService.getAttractionsCount(locationName: "Калининград"))
    }
}
