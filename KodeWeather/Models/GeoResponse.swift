//
//  GeoResponse.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

struct GeoResponse: Decodable {
    let response: GeoObjectCollection

    var locations: [Location] {
        return response.objectCollection.featureMember.map { Location(name: $0.geoObject.name, lan: Double($0.geoObject.point.pos.split(separator: " ")[0]) ?? 0, lon: Double($0.geoObject.point.pos.split(separator: " ")[0]) ?? 0) }
    }
}

struct GeoObjectCollection: Decodable {
    
    let objectCollection: GeoCollection

    enum CodingKeys: String, CodingKey {
       case objectCollection = "GeoObjectCollection"
    }
}

struct GeoCollection: Decodable  {
    let featureMember: [FutureMember]
}

struct FutureMember: Decodable  {
    let geoObject: GeoObject

    enum CodingKeys: String, CodingKey {
       case geoObject = "GeoObject"
    }
}

struct GeoObject: Decodable  {
    let name: String
    let point: Point

    enum CodingKeys: String, CodingKey {
        case name, point = "Point"
    }
}

struct Point: Decodable {
    let pos: String
}
