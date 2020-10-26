//
//  SearchPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Foundation
import MapKit

final class SearchPresenter: NSObject {
    // MARK: - Properties

    weak var view: SearchViewInput?
    var router: SearchRouterInput?

    private let GeoSerivce = GeoService()
    private let searchService = UserDefaultsService()

    private var searchLocations: [Location] = []

    private var searchViewModels: [SearchCellViewModel] = []

    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()

    override init() {
        super.init()
        self.searchCompleter.delegate = self
    }
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {
        searchLocations = searchService.getSearchLocations()
    }

    func cellViewModel(for indexPath: IndexPath) -> SearchCellViewModel? {
        guard searchViewModels.indices.count > indexPath.row else {
            return nil
        }
        return searchViewModels[indexPath.row]
    }

    func numberOfRows() -> Int {
        return searchViewModels.count
    }

    func selectRowAtIndexPath(at indexPath: IndexPath) {
        guard searchLocations.indices.count > indexPath.row else {
            return
        }
        searchService.saveSearchLocation(location: searchLocations[indexPath.row])
        router?.showWeatherModule(for: searchLocations[indexPath.row])
    }

    func fetchPreviewLocations(for query: String) {
        searchCompleter.queryFragment = query
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

//MARK: - MKLocalSearchCompleterDelegate
extension SearchPresenter: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.filter { result in
            guard result.title.contains(",") else { return false }
            guard result.subtitle.isEmpty else { return false }
            return true
        }
        var viewModels: [SearchCellViewModel] = []
        for result in results {
            viewModels.append(SearchCellViewModel(name: result.title, fullName: result.title))
        }
        searchViewModels = viewModels
        view?.reloadTableView()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("error complite")
    }
}
