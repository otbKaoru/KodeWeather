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
        guard let locationData = try? JSONEncoder().encode(location) else { return }
        defaults.set(locationData, forKey: UserDefaultsKeys.searchLocations)
    }
}

enum UserDefaultsKeys {
    static let searchLocations = "searchLocations"
}

