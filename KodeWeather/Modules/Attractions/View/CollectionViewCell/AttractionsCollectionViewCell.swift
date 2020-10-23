//
//  AttractionsCollectionViewCell.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import UIKit

final class AttractionsCollectionViewCell: UICollectionViewCell {

    private let attractionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = CellOptions.contentViewLayerCornerRadius
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let attractionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: CellOptions.attractionTitleFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        return label
    }()

    private let attractionDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: CellOptions.attractionDescriptionFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGradient()
        setupLayouts()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.layer.cornerRadius = CellOptions.contentViewLayerCornerRadius
        contentView.backgroundColor = .white
        contentView.addSubview(attractionImageView)
        contentView.addSubview(attractionTitle)
        contentView.addSubview(attractionDescription)
    }

    private func setupGradient() {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer.bounds = contentView.bounds.insetBy(dx: -0.5*contentView.bounds.size.width, dy: -0.5*contentView.bounds.size.height)
        layer.position = contentView.center
        attractionImageView.layer.addSublayer(layer)
    }

    private func setupLayouts() {
        attractionImageView.translatesAutoresizingMaskIntoConstraints = false
        attractionTitle.translatesAutoresizingMaskIntoConstraints = false
        attractionDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            attractionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            attractionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            attractionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            attractionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            attractionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            attractionTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            attractionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            attractionDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            attractionDescription.topAnchor.constraint(equalTo: attractionTitle.bottomAnchor, constant: LayoutOptions.descriptionTopPadding),
            attractionDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            attractionDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(image: UIImage?, title: String, description: String) {
        attractionImageView.image = image
        attractionTitle.text = title
        attractionDescription.text = description
    }
}

// MARK: - Constants

extension AttractionsCollectionViewCell {
    private enum CellOptions {
        static let attractionTitleFontSize: CGFloat = 18
        static let attractionDescriptionFontSize: CGFloat = 16
        static let contentViewLayerCornerRadius: CGFloat = 12
    }

    private enum LayoutOptions {
        static let descriptionTopPadding: CGFloat = 16
    }
}
