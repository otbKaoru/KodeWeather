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

    private let todayWeatherCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StyleGuide.Colors.darkGrey
        setupCollectionViews()
        setupLayouts()
    }

    private func setupCollectionViews() {
        view.addSubview(todayWeatherCollectionView)
        view.backgroundColor = StyleGuide.Colors.darkGrey
        todayWeatherCollectionView.dataSource = self
        todayWeatherCollectionView.delegate = self
        todayWeatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
    }

    private func setupLayouts() {
        todayWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            todayWeatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todayWeatherCollectionView.heightAnchor.constraint(equalToConstant: 140),
            todayWeatherCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            todayWeatherCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// MARK: - WeatherViewInput

extension  WeatherViewController: WeatherViewInput {

}

// MARK: - UICollectionViewDelegate & DataSource

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 120)
    }
}
