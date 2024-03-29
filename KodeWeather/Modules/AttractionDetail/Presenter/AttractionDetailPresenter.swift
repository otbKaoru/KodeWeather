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
    var router: AttractionDetailRouterInput?

    private let attractionService: AttractionService = AttractionService()
    var attraction: Attraction?
}

extension AttractionDetailPresenter: AttractionDetailViewOutput {
    func mapTapped() {
        router?.showFullMap(lan: attraction?.geo?.lan ?? 0, lon: attraction?.geo?.lon ?? 0)
    }

    func viewLoaded() {
        guard let attraction = attraction else { return }
        view?.configure(images: attraction.images ?? [], title: attraction.name ?? "", description: attraction.desc ?? "", fullDescription: attraction.descfull ?? "")
        view?.configureMap(lan: attraction.geo?.lan ?? 0, lon: attraction.geo?.lon ?? 0)
        view?.configureTitle(title: attraction.name)
    }
}
