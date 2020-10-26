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

    private let geoService = GeoService()
    private let searchService = UserDefaultsService()

    private var searchLocations: [Location] = []

    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()

    override init() {
        super.init()
        searchCompleter.delegate = self
    }
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {
        searchLocations = searchService.getSearchLocations()
    }

    func cellViewModel(for indexPath: IndexPath) -> SearchCellViewModel? {
        guard searchResults.indices.count > indexPath.row else {
            return nil
        }
        return SearchCellViewModel(name: searchResults[indexPath.row].title, fullName: searchResults[indexPath.row].title)
    }

    func numberOfRows() -> Int {
        return searchResults.count
    }

    func selectRowAtIndexPath(at indexPath: IndexPath) {
        guard searchResults.indices.count > indexPath.row else {
            return
        }

        geoService.fetchGeoForQuery(query: searchResults[indexPath.row].title) { [weak self] (result) in
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self?.router?.showWeatherModule(for: data)
                case .failure(let error):
                    print(error)
                }
            }
    }


    func fetchPreviewLocations(for query: String) {
        searchCompleter.queryFragment = query
    }

    func fetchAllLocations(for query: String) {
        geoService.fetchGeoData(query: query, resultsCount: 50) { [weak self] (result) in
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
        searchResults = results
        view?.reloadTableView()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("error search")
    }
}
