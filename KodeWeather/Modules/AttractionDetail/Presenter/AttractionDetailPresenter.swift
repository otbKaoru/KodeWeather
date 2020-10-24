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
    private var attraction: Attraction?
}

extension AttractionDetailPresenter: AttractionDetailViewOutput {
    func viewLoaded() {
        attraction = attractionService.fetchLocationAttractions(locationName: "Калининград")[0]
        if let attraction = attraction {
           print(attraction)

            view?.configure(images: attraction.images ?? [], title: attraction.name ?? "", description: attraction.desc ?? "")
            view?.configureMap(lan: attraction.geo!.lan, lon: attraction.geo!.lon)
        }

    }
}
