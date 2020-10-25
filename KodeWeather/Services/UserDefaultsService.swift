//
//  UserDefaultsService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

private let defaults = UserDefaults.standard

final class UserDefaultsService {
    func getSearchLocations() -> [Location] {
        guard let savedData = defaults.object(forKey: UserDefaultsKeys.searchLocations) as? Data else {
            return [] }
        guard let locations = try? JSONDecoder().decode([Location].self, from: savedData) else {
            return [] }
        return locations
    }

    func saveSearchLocation(location: Location) {
        var savedLocations = getSearchLocations()
        if getSearchLocations().count < Options.maxSearchCount {
            savedLocations.append(location)
            guard let locationsData = try? JSONEncoder().encode(savedLocations) else { return }
            defaults.set(locationsData, forKey: UserDefaultsKeys.searchLocations)
        } else {
            savedLocations.removeLast()
            savedLocations.insert(location, at: 0)
            guard let locationsData = try? JSONEncoder().encode(savedLocations) else { return }
            defaults.set(locationsData, forKey: UserDefaultsKeys.searchLocations)
        }

    }
}

extension UserDefaultsService {
    private enum Options {
        static let maxSearchCount = 4
    }
}

enum UserDefaultsKeys {
    static let searchLocations = "searchLocations"
}

