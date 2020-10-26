//
//  SearchTableSectionHeaderView.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import UIKit

class SearchTableSectionHeaderView: UIView {

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: ViewOptions.statusLabelFontSize)
        label.textColor = StyleGuide.Colors.middleGrayTextColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupLayouts()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(statusLabel)
    }

    private func setupLayouts() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutOptions.statusLabelHorizontalPadding),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutOptions.statusLabelHorizontalPadding)
        ])
    }

    func configure(with text: String) {
        statusLabel.text = text
    }

}

extension SearchTableSectionHeaderView {
    private enum ViewOptions {
        static let statusLabelFontSize: CGFloat = 18
    }

    private enum LayoutOptions {
        static let statusLabelHorizontalPadding: CGFloat = 23
    }
}

