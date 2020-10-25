//
//  AttractionsViewOutput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

protocol AttractionsViewOutput {
    func viewLoaded()
    func cellViewModel(for indexPath: IndexPath) -> AttractionCellViewModel?
    func numberOfRows() -> Int 
}
