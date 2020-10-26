//
//  GeoService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation

protocol GeoServiceProtocol {
    func fetchGeoDataq(query: String, resultsCount: Int, completion: @escaping (SearchResponse))
}

typealias SearchResponse = (Result<[Location]?, NetworkError>) -> Void

final class GeoService: GeoServiceProtocol {
    func fetchGeoDataq(query: String, resultsCount: Int, completion: @escaping (SearchResponse)) {

    }

    private let networkService: NetworkServiceProtocol = NetworkService()

    func fetchGeoData(query: String, resultsCount: Int, completion: @escaping (Result<GeoResponse?, NetworkError>) -> Void) {
        let parametres: [String: Any]
        parametres = ["format":RequestOptions.format,
                      "apikey":RequestOptions.apiKey,
                      "geocode":query,
                      "results":resultsCount]
        networkService.fetchDecodableData(API:  ApiURL.yandexGeocode, parametres: parametres, completion: completion)
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
