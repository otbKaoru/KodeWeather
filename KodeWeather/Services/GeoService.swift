//
//  GeoService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation
import MapKit

protocol GeoServiceProtocol {
    func fetchGeoData(query: String, completion: @escaping (SearchResponse))
    func fetchGeoForLocationName(location: Location, completion: @escaping (Result<Location, NetworkError>) -> Void)
}

typealias SearchResponse = (Result<[Location], NetworkError>) -> Void

final class GeoService: NSObject, GeoServiceProtocol {
    private let networkService: NetworkServiceProtocol = NetworkService()
    private var searchCompleter: MKLocalSearchCompleter?

    private var queryCompletion: SearchResponse? = nil

    override init() {
        super.init()
        if AppSettings.searchBackend == .mkLocalSearch {
            searchCompleter = MKLocalSearchCompleter()
            searchCompleter?.delegate = self
        }
    }
    
    func fetchGeoData(query: String, completion: @escaping (SearchResponse)) {
        switch AppSettings.searchBackend {
        case .yandex:
            let parametres: [String: Any]
            parametres = ["format":RequestOptions.format,
                          "apikey":RequestOptions.apiKey,
                          "geocode":query,
                          "results":RequestOptions.resultCount]
            networkService.fetchDecodableData(API: ApiURL.yandexGeocode, parametres: parametres) { (result: Result<GeoResponse?, NetworkError>) in
                switch result {
                case .success(let data):
                    if let data = data {
                        completion(.success(data.locations))
                    } else {
                        completion(.success([]))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .mkLocalSearch:
            self.queryCompletion = completion
            searchCompleter?.queryFragment = query
        }

    }

    func fetchGeoForLocationName(location: Location, completion: @escaping (Result<Location, NetworkError>) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = location.fullname
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else { return }
            let location = Location(name: location.name, fullname: location.fullname, lan: placeMark.coordinate.latitude, lon: placeMark.coordinate.longitude)
            completion(.success(location))
        }
    }
}

//MARK: - MKLocalSearchCompleterDelegate
extension GeoService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let firstTitle = String(completer.results.first?.title.split(separator: ",")[0] ?? "")
        let results = completer.results.filter { result in
            guard result.title.contains(",") else { return false }
            guard result.subtitle.isEmpty else { return false }
            if result != completer.results.first {
                guard String(result.title.split(separator: ",")[0]) != firstTitle else { return false }
            }
            return true
        }.map({ Location(name: String($0.title.split(separator: ",")[0]), fullname: $0.title, lan: nil, lon: nil)})
        if let completion = queryCompletion {
            completion(.success(results))
        }
    }
}


extension GeoService {
    private enum ApiURL {
        static let yandexGeocode = "https://geocode-maps.yandex.ru/1.x/?"
    }

    private enum RequestOptions {
        static let format = "json"
        static let apiKey = "5f888f23-5862-49fe-8c33-52c15c89a84a"
        static let resultCount = 50
    }
}
