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
    private let location = Location(name: "Калиниград", lat: 54.70649, lon: 20.51095)

    private var todayWeatherViewModels: [WeatherCellViewModel] = []
    private var tomorrowWeatherViewModels: [WeatherCellViewModel] = []

    private func weatherDataDidRecieve(data: WeatherResponse?) {
        guard let data = data else {
            return
        }
        let days = weatherService.getDataDays(data: data)
        if days.indices.count >= 2 {
            view?.setForecastViewDate(date: days[0], forecast: .today)
            view?.setForecastViewDate(date: days[1], forecast: .tomorrow)
            todayWeatherViewModels = viewModelsFromDataForDay(data: data, day: days[0].day())
            tomorrowWeatherViewModels = viewModelsFromDataForDay(data: data, day: days[1].day())
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
            if date.day() == day {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let hourString = formatter.string(from: date)
                let descripiton = hourly.weather.indices.count > 0
                    ? WeatherType(fromRawValue: hourly.weather[0].main).Localization
                    : ""
                let imageName = hourly.weather.indices.count > 0
                    ? WeatherType(fromRawValue: hourly.weather[0].main).imageName
                    : ""
                viewmodels.append(WeatherCellViewModel(imageName: imageName, description: descripiton, hour: hourString))
            }

        }
        return viewmodels
    }
}

// MARK: - SearchViewOutput
extension WeatherPresenter: WeatherViewOutput {
    func viewLoaded() {
        view?.setLocationName(name: location.name)
        view?.configureMap(location: location)
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
