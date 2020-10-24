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

    private func fetchData<T: Decodable>(API: String, parametres: [String: Any] = [:], completion: @escaping (Result<T?, NetworkError>) -> Void) {
        guard let url = URL(string: API) else { return }
        networkService.getJSONData(URL: url, parameters: parametres) { result  in
            switch result {
            case .success(let data):
                let summary = try? JSONDecoder().decode(T.self, from: data)
                completion(.success(summary))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchGeoData(location: String, completion: @escaping (Result<GeoResponse?, NetworkError>) -> Void) {
        let parametres: [String: Any]
        parametres = ["format":"json",
                      "apikey":"5f888f23-5862-49fe-8c33-52c15c89a84a",
                      "kind":"locality",
                      "geocode":"Калиниград",
                      "results":2]
        fetchData(API:  ApiURL.yandexGeocode, parametres: parametres, completion: completion)
    }
}

extension GeoService {
    enum ApiURL {
        static let yandexGeocode = "https://geocode-maps.yandex.ru/1.x/?"
    }
}
