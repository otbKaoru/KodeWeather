//
//  WeatherType.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

enum WeatherType: String {
    case clear = "Clear"
    case clouds = "Clouds"
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case atmosphere = "Mist"
    case tornado = "Tornado"

    init(fromRawValue: String){
        self = WeatherType(rawValue: fromRawValue) ?? .atmosphere
    }

    var Localization: String {
        switch self {
        case .clear:
            return "Ясно"
        case .clouds:
            return "Облачно"
        case .thunderstorm:
            return "Гроза"
        case .drizzle:
            return "Морось"
        case .rain:
            return "Дождь"
        case .snow:
            return "Снег"
        case .atmosphere:
            return "Туман"
        case .tornado:
            return "Ураган"
        }
    }

    var imageName: String {
        switch self {
        case .clear:
            return "sun"
        case .clouds:
            return "sunOutCloud"
        case .thunderstorm:
            return "cloudLightningAndRain"
        case .drizzle:
            return "cloudRain"
        case .rain:
            return "cloudRain"
        case .snow:
            return "snowflake" 
        case .atmosphere:
            return "fog"
        case .tornado:
            return "tornado"
        }
    }
}


