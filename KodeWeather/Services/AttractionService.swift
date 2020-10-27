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
                let attractionCount = fetchLocationAttractionsCount()
                guard attractionCount == 0 else {
                    return
                }
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                guard let contextKey = CodingUserInfoKey.context else { return }
                decoder.userInfo[contextKey] = CoreDataService.shared.getContext()
                let jsonData = try decoder.decode([Attraction].self, from: data)
                if attractionCount != jsonData.count {
                    CoreDataService.shared.saveContext()
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

    func fetchLocationAttractionsCount() -> Int {
        let fetchedValues = CoreDataService.shared.fetchDataWithPredicate(predicateFormat: nil, predicateValue: "") as [Geo]
        return fetchedValues.count
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


