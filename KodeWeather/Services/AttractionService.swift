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

    func loadAttractionJson() {
        CoreDataService.instance.clearData()

        if let url = Bundle.main.url(forResource: Options.jsonName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                guard let contextKey = CodingUserInfoKey.context else { return }
                decoder.userInfo[contextKey] = CoreDataService.instance.getContext()
                let jsonData = try decoder.decode([Attraction].self, from: data)
                for attraction in jsonData {
                    CoreDataService.instance.saveContext()
                }
            } catch {
                print("error:\(error)")
            }
        }

        return
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


