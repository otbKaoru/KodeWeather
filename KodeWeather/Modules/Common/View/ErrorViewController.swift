//
//  ErrorViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 27.10.2020.
//

import UIKit

final class ErrorViewController: UIViewController {

    // MARK: - Properties

    private let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = StyleGuide.Colors.blue
        button.setTitle(Localization.Common.confirmButtonTitle, for: .normal)
        button.layer.cornerRadius = ViewOptions.contentCornerRadius
        button.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        return button
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: ViewOptions.descriptionLabelFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.text = Localization.Common.errorDescription
        label.numberOfLines = 0
        return label
    }()

    private let gearsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = ViewOptions.contentCornerRadius
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "gear")
        return imageView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupLayouts()
    }

    private func setupViews() {
        view.addSubview(confirmButton)
        view.addSubview(descriptionLabel)
        view.addSubview(gearsImageView)
    }


    private func setupLayouts() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        gearsImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutOptions.contentHorizontalPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutOptions.contentHorizontalPadding),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutOptions.contentHorizontalPadding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutOptions.contentHorizontalPadding),
            confirmButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutOptions.configButtonTopPadding),
            confirmButton.heightAnchor.constraint(equalToConstant: LayoutOptions.configButtonHeight)
        ])

        NSLayoutConstraint.activate([
            gearsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gearsImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -LayoutOptions.configButtonTopPadding),
            gearsImageView.heightAnchor.constraint(equalToConstant: LayoutOptions.imageHeight)
        ])

    }
}

//MARK: - UIActions

extension ErrorViewController {
    @objc func confirmButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constants

extension ErrorViewController {
    private enum ViewOptions {
        static let contentCornerRadius: CGFloat = 12
        static let descriptionLabelFontSize: CGFloat = 20

    }

    private enum LayoutOptions {
        static let configButtonHeight: CGFloat = 50
        static let contentHorizontalPadding: CGFloat = 30
        static let configButtonTopPadding: CGFloat = 30
        static let imageHeight: CGFloat = 100
    }
}
