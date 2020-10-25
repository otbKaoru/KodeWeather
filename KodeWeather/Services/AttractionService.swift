//
//  AttractionService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation
import CoreData

protocol AttractionServiceProtocol {
    func isLocationHaveAttractions(locationName: String) -> Bool
    func fetchLocationAttractions(locationName: String) -> [Attraction]
}

final class AttractionService: AttractionServiceProtocol {

    func loadAttractionJson() -> Attraction? {
        if let url = Bundle.main.url(forResource: Options.jsonName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                guard let contextKey = CodingUserInfoKey.context else { return nil }
                decoder.userInfo[contextKey] = CoreDataService.instance.getContext()
                let jsonData = try decoder.decode(Attraction.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    func fetchLocationAttractions(locationName: String) -> [Attraction] {
        return CoreDataService.instance.fetchDataWithPredicate(predicateFormat: "geo.name == %@", predicateValue: locationName) as [Attraction]
    }

    func isLocationHaveAttractions(locationName: String) -> Bool {
        let fetchedValues = CoreDataService.instance.fetchDataWithPredicate(predicateFormat: "name == %@", predicateValue: locationName) as [Geo]
        return fetchedValues.count > 0
    }
}

//MARK: - Constants

extension AttractionService {
    private enum Options {
        static let jsonName = "Attractions"
    }
}


