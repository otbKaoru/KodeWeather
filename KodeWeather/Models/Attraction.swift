//
//  Attraction.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

struct Attraction: Codable {
    let name: String
    let images: [String]
    let desc: String
    let descfull: String
    let geo: Geo
}

struct Geo: Codable {
    let lan: Double
    let lon: Double
}
