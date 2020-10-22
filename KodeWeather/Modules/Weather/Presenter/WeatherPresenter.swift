//
//  WeatherPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

final class WeatherPresenter {

    // MARK: - Properties

    weak var view: WeatherViewInput?
    private let weatherService: WeatherServiceProtocol = WeatherService()
}

// MARK: - SearchViewOutput
extension WeatherPresenter: WeatherViewOutput {
    func viewLoaded() {
        weatherService.fetchWeatherData(country: "") { (result) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
