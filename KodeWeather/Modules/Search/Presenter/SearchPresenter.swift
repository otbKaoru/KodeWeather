//
//  SearchPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

final class SearchPresenter {

    // MARK: - Properties

    weak var view: SearchViewInput?

    private let GeoSerivce = GeoService()
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewLoaded() {
        GeoSerivce.fetchGeoData(query: "Калининград", resultsCount: 10) { (result) in
            switch result {
            case .success(let data):
                print(data?.locations)
            case .failure(let error):
                print(error)
            }
        }
    }
}
