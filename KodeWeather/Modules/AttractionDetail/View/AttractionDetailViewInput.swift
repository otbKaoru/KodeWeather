//
//  AttractionDetailViewInput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

protocol AttractionDetailViewInput: class {
    func configure(images: [String], title: String, description: String)
    func configureMap(lan: Double, lon: Double)
}
