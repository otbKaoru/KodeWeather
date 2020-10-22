//
//  WeatherCollectionViewCell.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 22.10.2020.
//

import UIKit

final class WeatherCollectionViewCell: UICollectionViewCell {

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: CellOptions.timeLabelFontSize, weight: .init(CellOptions.timeLabelFontWeight))
        label.textColor = StyleGuide.Colors.defaultTextColor
        return label
    }()

    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: CellOptions.weatherLabelFontSize, weight: .init(CellOptions.weatherLabelFontWeight))
        label.textColor = StyleGuide.Colors.defaultTextColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = StyleGuide.Colors.middleGray
        contentView.layer.cornerRadius = CellOptions.contentViewLayerCornerRadius
        contentView.addSubview(weatherImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherLabel)
    }

    private func setupLayouts() {
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutOptions.weatherImageTopPadding),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: LayoutOptions.weatherImageHeight)
        ])

        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(image: UIImage?, time: String, weather: String) {
        weatherImageView.image = image
        timeLabel.text = time
        weatherLabel.text = weather
    }
    
}

//MARK: - Constants

extension WeatherCollectionViewCell {
    private enum CellOptions {
        static let timeLabelFontSize: CGFloat = 16
        static let timeLabelFontWeight: CGFloat = 400
        static let weatherLabelFontSize: CGFloat = 13
        static let weatherLabelFontWeight: CGFloat = 500
        static let contentViewLayerCornerRadius: CGFloat = 8
    }

    private enum LayoutOptions {
        static let weatherImageTopPadding: CGFloat = 16
        static let weatherImageHeight: CGFloat = 40
    }
}