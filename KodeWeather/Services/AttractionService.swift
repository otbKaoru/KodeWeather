//
//  AttractionService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation
import CoreData

protocol AttractionServiceProtocol {
}

final class AttractionService: AttractionServiceProtocol {

    private func loadAttractionJson() -> AttractionModel? {
        if let url = Bundle.main.url(forResource: Options.jsonName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(AttractionModel.self, from: data)
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

    func getAttractionsCount(locationName: String) -> Int {
        let fetchedValues = CoreDataService.instance.fetchDataWithPredicate(predicateFormat: "name == %@", predicateValue: locationName) as [Geo]
        return fetchedValues.count
    }

}

//MARK: - Constants

extension AttractionService {
    private enum Options {
        static let jsonName = "Attractions"
    }
}


