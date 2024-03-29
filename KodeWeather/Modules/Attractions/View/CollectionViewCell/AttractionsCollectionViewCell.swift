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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let attractionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: CellOptions.attractionTitleFontSize, weight: .semibold)
        label.textColor = StyleGuide.Colors.defaultTextColor
        return label
    }()

    private let attractionDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
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
        layer.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.6)

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
            attractionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutOptions.textPadding),
            attractionTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            attractionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutOptions.textPadding)
        ])

        NSLayoutConstraint.activate([
            attractionDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutOptions.textPadding),
            attractionDescription.topAnchor.constraint(equalTo: attractionTitle.bottomAnchor, constant: LayoutOptions.descriptionTopPadding),
            attractionDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutOptions.textPadding),
            attractionDescription.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -LayoutOptions.textPadding)
        ])
    }

    func configure(image: UIImage?, title: String, description: String) {
        attractionImageView.image = image
        attractionTitle.text = title
        attractionDescription.text = description
    }

    func configure(with viewModel: AttractionCellViewModel) {
        attractionImageView.setImage(with: URL(string: viewModel.imageName))
        attractionTitle.text = viewModel.title
        attractionDescription.text = viewModel.description
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
        static let textPadding: CGFloat = 8
    }
}
