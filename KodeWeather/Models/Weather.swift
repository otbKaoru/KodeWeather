//
//  Weather.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 22.10.2020.
//

struct WeatherAPIResponse {
    let hourly: Hourly
}

struct Hourly {
    let dt: Int
    let weather: Weather
}

struct Weather {
    let description: String
    let main: String
}
