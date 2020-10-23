//
//  AttractionDetailPresenter.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import Foundation

final class AttractionDetailPresenter {

    // MARK: - Properties

    weak var view: AttractionDetailViewInput?
}

extension AttractionDetailPresenter: AttractionDetailViewOutput {
    func viewLoaded() {
    }
}
