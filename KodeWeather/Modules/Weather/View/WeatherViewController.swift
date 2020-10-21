//
//  WeatherViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

final class WeatherViewController: UIViewController {

    // MARK: - Properties

    var output: WeatherViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StyleGuide.Colors.darkGrey
        setupLayouts()
    }

    private func setupLayouts() {
    }
}

// MARK: - WeatherViewInput

extension  WeatherViewController: WeatherViewInput {

}
