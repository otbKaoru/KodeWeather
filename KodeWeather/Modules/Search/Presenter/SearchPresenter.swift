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

    private var isShowedLastQueries = false

    private func showError() {
        router?.showError()
    }
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {
        let locations = dataService.getSearchLocations()
        if locations.count > 0 {
            isShowedLastQueries = true
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

    func isColorDefault() -> Bool {
        return !isShowedLastQueries
    }

    func selectRowAtIndexPath(at indexPath: IndexPath) {
        guard searchLocations.indices.count > indexPath.row else {
            return
        }
        let location = searchLocations[indexPath.row]
        if location.lan != nil && location.lon != nil {
            dataService.saveSearchLocation(location: location )
            router?.showWeatherModule(for: location)
        } else {
            geoSerivce.fetchGeoForLocationName(location: location) { [weak self] (result) in
                switch result {
                case .success(let location):
                    self?.dataService.saveSearchLocation(location: location )
                    self?.router?.showWeatherModule(for: location)
                case .failure(_):
                    self?.showError()
                }
            }
        }
    }

    func fetchPreviewLocations(for query: String) {
        geoSerivce.fetchGeoData(query: query) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.isShowedLastQueries = false
                self?.searchLocations = data.enumerated().filter({$0.offset < 5}).map { $0.element }
                if data.count > 0 {
                    self?.view?.configureHeader(text: Localization.Search.headerSearch)
                } else {
                    if query != "" {
                        self?.view?.configureHeader(text: Localization.Search.headerSearchNoResults)
                    }
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
                self?.isShowedLastQueries = false
                self?.searchLocations = data
                if data.count > 0 {
                    self?.view?.configureHeader(text: Localization.Search.headerSearch)
                } else {
                    if query != "" {
                        self?.view?.configureHeader(text: Localization.Search.headerSearchNoResults)
                    }
                }
                self?.view?.reloadTableView()
            case .failure(_):
                self?.showError()
            }
        }
    }

    func cancelSearch() {
        view?.configureHeader(text: "")
        searchLocations = []
        view?.reloadTableView()
    }
}
