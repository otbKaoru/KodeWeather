//
//  AppSettings.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 26.10.2020.
//

enum AppSettings {
    static let searchBackend: SearchBackend = .yandex
}

enum SearchBackend {
    case yandex
    case mkLocalSearch
}
