//
//  SearchTableViewCell.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    private func setup() {
        contentView.backgroundColor = StyleGuide.Colors.darkGray
        textLabel?.textColor = StyleGuide.Colors.defaultTextColor
        textLabel?.font = UIFont.systemFont(ofSize: CellOptions.textLabelFonSize, weight: .heavy)
    }

    func configure(with text: String, textColor: UIColor) {
        textLabel?.text = text
        textLabel?.textColor = textColor
    }
}

//MARK: - Constants
extension SearchTableViewCell {
    private enum CellOptions {
        static let textLabelFonSize: CGFloat = 32
    }
}
