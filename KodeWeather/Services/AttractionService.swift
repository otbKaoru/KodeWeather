//
//  AttractionService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Foundation

final class AttractionService {

    func loadJson(filename fileName: String) -> AttractionModel? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
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
}



