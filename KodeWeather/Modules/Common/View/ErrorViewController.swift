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
        button.setTitle(Localization.Weather.attractionsButtonTitle, for: .normal)
        button.layer.cornerRadius = ViewOptions.сonfirmButtomCornerRadius
        button.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        return button
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
    }


    private func setupLayouts() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutOptions.configButtonHorizontalPadding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutOptions.configButtonHorizontalPadding),
            confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: LayoutOptions.configButtonHeight)
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
        static let сonfirmButtomCornerRadius: CGFloat = 12

    }

    private enum LayoutOptions {
        static let configButtonHeight: CGFloat = 50
        static let configButtonHorizontalPadding: CGFloat = 30
    }
}
