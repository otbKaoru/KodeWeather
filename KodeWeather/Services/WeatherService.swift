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
}

extension WeatherService: WeatherServiceProtocol {
    func fetchWeatherData(location: Location, completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void) {
        let parametres: [String: Any]
        parametres = ["lat":location.lan ?? 0,
                      "lon":location.lon ?? 0,
                      "exclude":RequestOptions.exclude,
                      "lang":RequestOptions.lang,
                      "units":RequestOptions.units,
                      "appid":RequestOptions.appid]
        networkService.fetchDecodableData(API:  ApiURL.openWeather, parametres: parametres, completion: completion)
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
