//
//  SearchViewInput.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

protocol SearchViewInput: class {
    func reloadTableView()
    func configureHeader(text: String)
}
