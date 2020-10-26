//
//  WeatherForecastView.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 22.10.2020.
//

import UIKit

class WeatherForecastView: UIView {

    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: ViewOptions.dateLabelFontSize)
        label.textColor = StyleGuide.Colors.middleGrayTextColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(dateLabel)
        addSubview(collectionView)

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = StyleGuide.Colors.darkGray
    }

    private func setupLayouts() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutOptions.textHorizontalPadding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutOptions.textHorizontalPadding)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: LayoutOptions.collectionViewTopPadding),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(for date: Date, forecast: ForecastType) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateLabel.text = forecast.localization + " \(dateFormatter.string(from: date))"
        }
}

//MARK: - Constants

extension WeatherForecastView {
    private enum ViewOptions {
        static let dateLabelFontSize: CGFloat = 16
    }

    private enum LayoutOptions {
        static let collectionViewTopPadding: CGFloat = 16
        static let textHorizontalPadding: CGFloat = 24
    }

}

