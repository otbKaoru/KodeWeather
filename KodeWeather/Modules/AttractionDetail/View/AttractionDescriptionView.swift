//
//  AttractionDescriptionView.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 26.10.2020.
//

import UIKit


class AttractionDescriptionView: UIView {

    private let attractionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: ViewOptions.attractionDescriptionFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.numberOfLines = 0
        return label
    }()

    private let readMoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: ViewOptions.attractionDescriptionFontSize)
        label.textColor = ViewOptions.readMoreTextColor
        label.text = Localization.AttractionDetail.readMoreTitle
        //label.addTarget(self, action: #selector(readMoreLabelTap))
        return label
    }()

    private var desc = ""
    private var fullDesc = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(attractionDescriptionLabel)
        addSubview(readMoreLabel)

        let labelGesture = UITapGestureRecognizer(target: self, action: #selector(readMoreLabelTap))
        readMoreLabel.isHidden = true
        readMoreLabel.isUserInteractionEnabled = true
        readMoreLabel.addGestureRecognizer(labelGesture)
    }

    private func setupLayouts() {
        attractionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        readMoreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            attractionDescriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            attractionDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
            attractionDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        NSLayoutConstraint.activate([
            readMoreLabel.topAnchor.constraint(equalTo: attractionDescriptionLabel.bottomAnchor),
            readMoreLabel.leftAnchor.constraint(equalTo: leftAnchor),
            readMoreLabel.rightAnchor.constraint(equalTo: rightAnchor),
            readMoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func hideReadMoreLabel() {
        readMoreLabel.text = ""
        readMoreLabel.isHidden = true
    }

    func configure(desc: String, fullDesc: String) {
        readMoreLabel.isHidden = false
        self.desc = desc
        self.fullDesc = fullDesc
        if desc.count >= fullDesc.count {
            hideReadMoreLabel()
        }
        attractionDescriptionLabel.text = desc
    }
}

//MARK: - UIActions

extension AttractionDescriptionView {
    @objc func readMoreLabelTap() {
        attractionDescriptionLabel.text = fullDesc
        hideReadMoreLabel()
    }
}


//MARK: - Constants
extension AttractionDescriptionView {
    private enum ViewOptions {
        static let attractionDescriptionFontSize: CGFloat = 16
        static let readMoreTextColor = UIColor(hex: "#37A1F5")
    }
}


