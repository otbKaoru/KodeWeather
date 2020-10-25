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
    var router: SearchRouterInput?

    private let GeoSerivce = GeoService()
    private let searchService = UserDefaultsService()

    private var searchLocations: [Location] = []
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {
        searchLocations = searchService.getSearchLocations()
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

    func selectRowAtIndexPath(at indexPath: IndexPath) {
        guard searchLocations.indices.count > indexPath.row else {
            return
        }
        searchService.saveSearchLocation(location: searchLocations[indexPath.row])
        router?.showWeatherModule(for: searchLocations[indexPath.row])
    }

    func fetchPreviewLocations(for query: String) {
        GeoSerivce.fetchGeoData(query: query, resultsCount: 100) { [weak self] (result) in
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
