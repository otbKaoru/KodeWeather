//
//  AttractionDescriptionLabel.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 26.10.2020.
//

import UIKit

class AttractionDescriptionLabel: UILabel {
    private var desc: String = ""
    private var fullDesc: String = ""

    private let showMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = StyleGuide.Colors.blue
        button.setTitle(Localization.Weather.attractionsButtonTitle, for: .normal)
        button.isHidden = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(showMoreButton)
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            showMoreButton.topAnchor.constraint(equalTo: topAnchor),
            showMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            showMoreButton.leftAnchor.constraint(equalTo: leadingAnchor),
            showMoreButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func showMoreText() {
        text = fullDesc
    }


    func showLessText() {
        text = desc
    }
}
