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
    func fetchGeoForLocationName(locationName: String, completion: @escaping (Result<Location, NetworkError>) -> Void)
}

typealias SearchResponse = (Result<[Location], NetworkError>) -> Void

final class GeoService: GeoServiceProtocol {
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    func fetchGeoData(query: String, completion: @escaping (SearchResponse)) {
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
                    completion(.failure(NetworkError.networkError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchGeoForLocationName(locationName: String, completion: @escaping (Result<Location, NetworkError>) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationName
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                completion(.failure(.networkError))
                return
            }
            let location = Location(name: locationName, lan: placeMark.coordinate.latitude, lon: placeMark.coordinate.longitude)
            completion(.success(location))
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
