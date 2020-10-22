//
//  WeatherViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit
import MapKit

final class WeatherViewController: UIViewController {

    // MARK: - Properties

    var output: WeatherViewOutput?

    let mapView = MKMapView()

    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: SubviewsOptions.locationLabelFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.text = "Калининград"
        return label
    }()

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
        setupViews()
        setupWeatherCollectionView(collectionView: todayWeatherCollectionView)
        setupWeatherCollectionView(collectionView: tomorrowWeatherCollectionView)
        setupMapView()
        setupLayouts()
    }

    private func setupViews() {
        view.addSubview(locationNameLabel)
    }

    private func setupWeatherCollectionView(collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = StyleGuide.Colors.darkGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
    }

    private func setupMapView() {
        view.addSubview(mapView)
    }

    private func setupLayouts() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        todayWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tomorrowWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 140),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            locationNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            todayWeatherCollectionView.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor),
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

// MARK: - Constants

extension WeatherViewController {
    private enum SubviewsOptions {
        static let locationLabelFontSize: CGFloat = 32
    }
}
