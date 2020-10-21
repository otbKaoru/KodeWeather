//
//  SearchViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Properties

    var output: SearchViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {

}
