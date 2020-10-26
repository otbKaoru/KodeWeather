//
//  GeoService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation
import UIKit
import MapKit

protocol GeoServiceProtocol {
}

final class GeoService: GeoServiceProtocol {
    private let networkService: NetworkServiceProtocol = NetworkService()

    func fetchGeoData(query: String, resultsCount: Int, completion: @escaping (Result<GeoResponse?, NetworkError>) -> Void) {
        let parametres: [String: Any]
        parametres = ["format":RequestOptions.format,
                      "apikey":RequestOptions.apiKey,
                      "geocode":query,
                      "results":resultsCount]
        networkService.fetchDecodableData(API:  ApiURL.yandexGeocode, parametres: parametres, completion: completion)
    }

    func fetchGeoForQuery(query: String, completion: @escaping (Result<Location?, NetworkError>) -> Void) {
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = query
//        let search = MKLocalSearch(request: searchRequest)
//        search.start { (response, error) in
//            guard error == nil else {
//                completion(.failure(.networkError))
//                return
//            }
//            guard let placeMark = response?.mapItems[0].placemark else {
//                completion(.failure(.networkError))
//                return
//            }
//            let location = Location(name: query, lan: placeMark.coordinate.latitude, lon: placeMark.coordinate.longitude)
//            completion(.success(location))
//        }

        let geocoder = CLGeocoder()
          geocoder.geocodeAddressString(query) { (response, error) in
                        guard error == nil else {
                            completion(.failure(.networkError))
                            return
                        }
                    guard let placeMark = response?[0] else {
                            completion(.failure(.networkError))
                            return
                        }
            let location = Location(name: query, lan: placeMark.location?.coordinate.latitude ?? 0, lon: placeMark.location?.coordinate.longitude ?? 0)
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
    }
}
