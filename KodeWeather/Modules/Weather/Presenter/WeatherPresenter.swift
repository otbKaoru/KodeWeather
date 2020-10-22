//
//  WeatherPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Foundation

final class WeatherPresenter {

    // MARK: - Properties

    weak var view: WeatherViewInput?
    private let weatherService: WeatherServiceProtocol = WeatherService()
    private let location = Location(name: "San-Fransisco", lat: 33.441792, lon: -94.037689)

    private var todayWeatherViewModels: [WeatherCellViewModel] = []
    private var tomorrowWeatherViewModels: [WeatherCellViewModel] = []

    private func weatherDataDidRecieve(data: WeatherResponse?) {
        guard let data = data else {
            return
        }
        let days = weatherService.getDataDays(data: data)
        if days.indices.count >= 2 {
            todayWeatherViewModels = viewModelsFromDataForDay(data: data, day: days[0])
            tomorrowWeatherViewModels = viewModelsFromDataForDay(data: data, day: days[1])

        }
        view?.reloadCollectionViewData()
    }

    private func viewModelsFromDataForDay(data: WeatherResponse?, day: Int) -> [WeatherCellViewModel] {
        var viewmodels: [WeatherCellViewModel] = []
        guard let data = data else {
            return []
        }
        for hourly in data.hourlyForecast {
            let date = Date(timeIntervalSince1970: hourly.dateTime)
            let calendar = Calendar.current
            let dataDay = calendar.component(.day, from: date)
            if dataDay == day {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let hourString = formatter.string(from: date)
                let descripiton = hourly.weather.indices.count > 0
                    ? hourly.weather[0].description
                    : ""
                viewmodels.append(WeatherCellViewModel(imageName: "sunBehindCloud", description: descripiton, hour: hourString))
            }

        }
        return viewmodels
    }
}

// MARK: - SearchViewOutput
extension WeatherPresenter: WeatherViewOutput {
    func viewLoaded() {
        weatherService.fetchWeatherData(location: location ) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.weatherDataDidRecieve(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }

    func cellViewModel(for indexPath: IndexPath, forecast: ForecastType) -> WeatherCellViewModel? {
        if forecast == .today {
            return todayWeatherViewModels[indexPath.row]
        }
        if forecast == .tomorrow {
            return tomorrowWeatherViewModels[indexPath.row]
        }
        return nil
    }

    func numberOfRows(forecast: ForecastType) -> Int {
        if forecast == .today {
            return todayWeatherViewModels.count
        }
        if forecast == .tomorrow {
            return tomorrowWeatherViewModels.count
        }
        return 0
    }
}
