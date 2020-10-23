//
//  AttractionsPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

final class AttractionsPresenter {

    // MARK: - Properties

    weak var view: AttractionsViewInput?
}

extension AttractionsPresenter: AttractionsViewOutput {
    func viewLoaded() {
    }
}
