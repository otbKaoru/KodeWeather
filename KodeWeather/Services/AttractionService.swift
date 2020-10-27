//
//  AttractionService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation

protocol AttractionServiceProtocol {
    func isLocationHaveAttractions(locationName: String) -> Bool
    func fetchLocationAttractions(locationName: String) -> [Attraction]
    func clearAttractionsData() 
}

final class AttractionService: AttractionServiceProtocol {

    func loadAttractionsFromJson() {
        if let url = Bundle.main.url(forResource: Options.jsonName, withExtension: "json") {
            do {
                let attractions = fetchAttractions()
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                guard let contextKey = CodingUserInfoKey.context else { return }
                decoder.userInfo[contextKey] = CoreDataService.shared.getContext()
                let jsonData = try decoder.decode([Attraction].self, from: data)
                if attractions.count != jsonData.count {
                    for attraction in attractions {
                        CoreDataService.shared.getContext().delete(attraction)
                    }
                    CoreDataService.shared.saveContext()
                } else {
                    for attraction in jsonData {
                        CoreDataService.shared.getContext().delete(attraction)
                    }
                }
            } catch {
                print("error:\(error)")
            }
        }

        return
    }

    func fetchLocationAttractions(locationName: String) -> [Attraction] {
        return CoreDataService.shared.fetchDataWithPredicate(predicateFormat: "geo.name == %@", predicateValue: locationName) as [Attraction]
    }

    func fetchAttractions() -> [Attraction] {
        return CoreDataService.shared.fetchDataWithPredicate(predicateFormat: nil, predicateValue: "") as [Attraction]
    }

    func isLocationHaveAttractions(locationName: String) -> Bool {
        let fetchedValues = CoreDataService.shared.fetchDataWithPredicate(predicateFormat: "name == %@", predicateValue: locationName) as [Geo]
        return fetchedValues.count > 0
    }

    func clearAttractionsData() {
        CoreDataService.shared.clearData()
    }
}

//MARK: - Constants

extension AttractionService {
    private enum Options {
        static let jsonName = "Attractions"
    }
}


