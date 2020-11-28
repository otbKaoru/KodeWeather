//
//  CustomTabBarController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 26.10.2020.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "kode")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        view.addSubview(imageView)
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView.frame = self.tabBar.frame
    }
}

