//
//  GeoResponse.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

struct GeoResponse: Decodable {
    let response: GeoObjectCollection
}

struct GeoObjectCollection: Decodable {
    let GeoObjectCollection: GeoCollection
}

struct GeoCollection: Decodable  {
    let featureMember: [FutureMember]
}

struct FutureMember: Decodable  {
    let GeoObject: GeoObject
}

struct GeoObject: Decodable  {
    let name: String
}
