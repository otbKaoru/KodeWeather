//
//  WeatherService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//
import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherData(location: Location, completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void)
}

final class WeatherService {
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
}

extension WeatherService: WeatherServiceProtocol {
    func fetchWeatherData(location: Location, completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void) {
        let parametres: [String: Any]
        parametres = ["lat":location.lat,
                      "lon":location.lon,
                      "exclude":RequestOptions.exclude,
                      "lang":RequestOptions.lang,
                      "units":RequestOptions.units,
                      "appid":RequestOptions.appid]
        fetchData(API:  ApiURL.openWeather, parametres: parametres, completion: completion)
    }
}

// MARK: - Constants
extension WeatherService {
    private enum ApiURL {
        static let openWeather = "https://api.openweathermap.org/data/2.5/onecall?"
    }

    private enum RequestOptions {
        static let lang = "ru"
        static let units = "metric"
        static let exclude = "current,minutely,daily,alerts"
        static let appid = "2db3c57ff9b75e40ba734e02ba73aa25"
    }
}
