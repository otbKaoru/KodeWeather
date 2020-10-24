//
//  SearchPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Foundation

final class SearchPresenter {

    // MARK: - Properties

    weak var view: SearchViewInput?

    private let GeoSerivce = GeoService()
    private var searchLocations: [Location] = []
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {

    }

    func cellViewModel(for indexPath: IndexPath) -> Location? {
        guard searchLocations.indices.count > indexPath.row else {
            return nil
        }
        return searchLocations[indexPath.row]
    }

    func numberOfRows() -> Int {
        return searchLocations.count
    }

    func fetchPreviewLocations(for query: String) {
        GeoSerivce.fetchGeoData(query: query, resultsCount: 20) { [weak self] (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    self?.searchLocations = data.locations
                    self?.view?.reloadTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchAllLocations(for query: String) {
        GeoSerivce.fetchGeoData(query: query, resultsCount: 50) { [weak self] (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    self?.searchLocations = data.locations
                    self?.view?.reloadTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
