//
//  SearchViewOutput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Foundation

protocol SearchViewOutput: class {
    func viewLoaded()
    func cellViewModel(for indexPath: IndexPath) -> Location?
    func fetchPreviewLocations(for query: String)
    func numberOfRows() -> Int
    func selectRowAtIndexPath(at indexPath: IndexPath)
    func fetchAllLocations(for query: String)
}
