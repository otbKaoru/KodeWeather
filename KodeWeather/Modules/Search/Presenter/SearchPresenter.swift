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

    private let geoSerivce: GeoServiceProtocol = GeoService()
    private let dataService = UserDefaultsService()

    private var searchLocations: [Location] = []

    private func showError() {
        router?.showError()
    }
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {
        let locations = dataService.getSearchLocations()
        if locations.count > 0 {
            view?.configureHeader(text: Localization.Search.headerSearchUserDefaults)
        }
        searchLocations = dataService.getSearchLocations()
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
        dataService.saveSearchLocation(location: searchLocations[indexPath.row])
        router?.showWeatherModule(for: searchLocations[indexPath.row])
    }

    func fetchPreviewLocations(for query: String) {
        geoSerivce.fetchGeoData(query: query) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.searchLocations = data
                if data.count > 0 {
                    self?.view?.configureHeader(text: Localization.Search.headerSearch)
                } else {
                    self?.view?.configureHeader(text: Localization.Search.headerSearchNoResults)
                }
                self?.view?.reloadTableView()
            case .failure(_):
                self?.showError()
            }
        }
    }

    func fetchAllLocations(for query: String) {
        geoSerivce.fetchGeoData(query: query) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.searchLocations = data
                if data.count > 0 {
                    self?.view?.configureHeader(text: Localization.Search.headerSearch)
                } else {
                    self?.view?.configureHeader(text: Localization.Search.headerSearchNoResults)
                }
                self?.view?.reloadTableView()
            case .failure(_):
                self?.showError()
            }
        }

    }
}
