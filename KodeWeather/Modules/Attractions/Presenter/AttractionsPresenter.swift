//
//  AttractionsPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

final class AttractionsPresenter {

    // MARK: - Properties

    weak var view: AttractionsViewInput?
    var locationName: String?

    private var attractionService: AttractionServiceProtocol = AttractionService()
    private var attractions: [Attraction] = []
}

extension AttractionsPresenter: AttractionsViewOutput {
    func viewLoaded() {
        guard let locationName = locationName else { return }
        attractions = attractionService.fetchLocationAttractions(locationName: locationName)
    }

    func cellViewModel(for indexPath: IndexPath) -> AttractionCellViewModel? {
        guard attractions.indices.count > indexPath.row else {
            return nil
        }
        return AttractionCellViewModel(imageName: attractions[indexPath.row].images?[0] ?? "", title: attractions[indexPath.row].name ?? "", description: attractions[indexPath.row].desc ?? "")
    }

    func numberOfRows() -> Int {
        return attractions.count
    }
}
