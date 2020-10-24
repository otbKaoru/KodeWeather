//
//  UIImageView + URL.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 24.10.2020.
//

import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
