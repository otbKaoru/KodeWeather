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
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()

    private let tomorrowWeatherCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupWeatherCollectionView(collectionView: todayWeatherCollectionView)
        setupWeatherCollectionView(collectionView: tomorrowWeatherCollectionView)
        setupLayouts()
    }

    private func setupWeatherCollectionView(collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = StyleGuide.Colors.darkGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
    }

    private func setupLayouts() {
        todayWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tomorrowWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            todayWeatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todayWeatherCollectionView.heightAnchor.constraint(equalToConstant: 140),
            todayWeatherCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            todayWeatherCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            tomorrowWeatherCollectionView.topAnchor.constraint(equalTo: todayWeatherCollectionView.bottomAnchor),
            tomorrowWeatherCollectionView.heightAnchor.constraint(equalToConstant: 140),
            tomorrowWeatherCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tomorrowWeatherCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
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
        cell.configure(image: UIImage(named: "sunBehindCloud"), time: "13:00", weather: "Облачно")
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 120)
    }
}
