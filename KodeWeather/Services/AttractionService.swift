//
//  AttractionService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation

protocol AttractionServiceProtocol {
    func isLocationHaveAttractions(location: String) -> Bool
    func fetchLocationAttractions(locationName: String) -> [Attraction]
}

final class AttractionService: AttractionServiceProtocol {

    func loadAttractionsFromJson() {
        CoreDataService.shared.clearData()

        if let url = Bundle.main.url(forResource: Options.jsonName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                guard let contextKey = CodingUserInfoKey.context else { return }
                decoder.userInfo[contextKey] = CoreDataService.shared.getContext()
                let _ = try decoder.decode([Attraction].self, from: data)
                CoreDataService.shared.saveContext()
            } catch {
                print("error:\(error)")
            }
        }

        return
    }

    func fetchLocationAttractions(locationName: String) -> [Attraction] {
        return CoreDataService.shared.fetchDataWithPredicate(predicateFormat: "geo.name == %@", predicateValue: locationName) as [Attraction]
    }

    func isLocationHaveAttractions(location: String) -> Bool {
        let fetchedValues = CoreDataService.shared.fetchDataWithPredicate(predicateFormat: "name == %@", predicateValue: location) as [Geo]
        return fetchedValues.count > 0
    }
}

//MARK: - Constants

extension AttractionService {
    private enum Options {
        static let jsonName = "Attractions"
    }
}


