//
//  WeatherResponse.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 22.10.2020.
//

struct WeatherResponse: Decodable {
    let hourlyForecast: Hourly

    enum CodingKeys: String, CodingKey {
       case hourlyForecast = "hourly" 
    }
}

struct Hourly: Decodable  {
    let dateTime: Int
    let weather: Weather

    enum CodingKeys: String, CodingKey {
       case dateTime = "dt"
       case weather
    }
}

struct Weather: Decodable  {
    let description: String
    let main: String
}
