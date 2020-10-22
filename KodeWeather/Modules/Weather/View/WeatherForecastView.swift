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
        label.text = "Сегодня, 26 янв 2020"
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
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - Constants

extension WeatherForecastView {
    enum ViewOptions {
        static let dateLabelFontSize: CGFloat = 16
    }
}

