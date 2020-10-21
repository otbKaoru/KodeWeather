//
//  SearchTableViewCell.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    private enum CellOptions {
        static let textLabelFonSize: CGFloat = 32
        static let textLabelFontWeight: CGFloat = 800
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    private func setup() {
        contentView.backgroundColor = StyleGuide.Colors.darkGrey
        textLabel?.textColor = StyleGuide.Colors.defaultTextColor
        textLabel?.font = UIFont.systemFont(ofSize: CellOptions.textLabelFonSize, weight: .init(rawValue: CellOptions.textLabelFontWeight))
    }

    func configure(with text: String) {
        textLabel?.text = text
    }
}
