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

    private let sightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = StyleGuide.Colors.blue
        button.setTitle(Localization.Weather.sightButtonTitle, for: .normal)
        button.layer.cornerRadius = SubviewsOptions.sightButtinCornetRadius
        return button
    }()

    private let todayWeatherView = WeatherForecastView()
    private let tomorrowWeatherView = WeatherForecastView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupMapView()
        setupLayouts()
    }

    private func setupViews() {
        setupWeatherView(weatherView: todayWeatherView)
        setupWeatherView(weatherView: tomorrowWeatherView)
        view.addSubview(locationNameLabel)
        view.addSubview(sightButton)
    }

    private func setupWeatherView(weatherView: WeatherForecastView) {
        view.addSubview(weatherView)
        view.layer.addSublayer(weatherView.layer)
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self
        weatherView.collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
    }

    private func setupMapView() {
        view.addSubview(mapView)
    }

    private func setupLayouts() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        todayWeatherView.translatesAutoresizingMaskIntoConstraints = false
        tomorrowWeatherView.translatesAutoresizingMaskIntoConstraints = false
        sightButton.translatesAutoresizingMaskIntoConstraints = false

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
            todayWeatherView.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor),
            todayWeatherView.heightAnchor.constraint(equalToConstant: 160),
            todayWeatherView.leftAnchor.constraint(equalTo: view.leftAnchor),
            todayWeatherView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            tomorrowWeatherView.topAnchor.constraint(equalTo: todayWeatherView.bottomAnchor, constant: LayoutOptions.weatherViewMargin),
            tomorrowWeatherView.heightAnchor.constraint(equalToConstant: 160),
            tomorrowWeatherView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tomorrowWeatherView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            sightButton.topAnchor.constraint(equalTo: tomorrowWeatherView.bottomAnchor, constant: LayoutOptions.weatherViewMargin),
            sightButton.heightAnchor.constraint(equalToConstant: LayoutOptions.sightButtonHeight),
            sightButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: LayoutOptions.sightButtonHorizontalPadding),
            sightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -LayoutOptions.sightButtonHorizontalPadding)
        ])
    }
}

// MARK: - WeatherViewInput

extension  WeatherViewController: WeatherViewInput {
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.todayWeatherView.collectionView.reloadData()
            self.tomorrowWeatherView.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate & DataSource

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == todayWeatherView.collectionView {
            return output?.numberOfRows(forecast: .today) ?? 0
        }
        if collectionView == tomorrowWeatherView.collectionView {
            return output?.numberOfRows(forecast: .tomorrow) ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier, for: indexPath) as! WeatherCollectionViewCell

        if collectionView == todayWeatherView.collectionView {
            if let viewModel = output?.cellViewModel(for: indexPath, forecast: .today) {
                cell.configure(with: viewModel)
                return cell
            }
        }
        if collectionView == tomorrowWeatherView.collectionView {
            if let viewModel = output?.cellViewModel(for: indexPath, forecast: .tomorrow) {
                cell.configure(with: viewModel)
                return cell
            }
        }
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
        static let sightButtinCornetRadius: CGFloat = 12
    }

    private enum LayoutOptions {
        static let weatherViewMargin: CGFloat = 16
        static let sightButtonHorizontalPadding: CGFloat = 18
        static let sightButtonHeight: CGFloat = 56
    }
}
