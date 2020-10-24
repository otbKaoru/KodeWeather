//
//  GeoService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation

protocol GeoServiceProtocol {
}

final class GeoService: GeoServiceProtocol {
    private let networkService: NetworkServiceProtocol = NetworkService()

    func fetchGeoData(location: String, completion: @escaping (Result<GeoResponse?, NetworkError>) -> Void) {
        let parametres: [String: Any]
        parametres = ["format":"json",
                      "apikey":"5f888f23-5862-49fe-8c33-52c15c89a84a",
                      "kind":"locality",
                      "geocode":"Калиниград",
                      "results":2]
        networkService.fetchDecodableData(API:  ApiURL.yandexGeocode, parametres: parametres, completion: completion)
    }
}

extension GeoService {
    enum ApiURL {
        static let yandexGeocode = "https://geocode-maps.yandex.ru/1.x/?"
    }
}