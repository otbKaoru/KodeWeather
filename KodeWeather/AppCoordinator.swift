//
//  AppCoordinator.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

class AppCoordinator: AppCoordinatorProtocol {

    private enum TabBarOptions {
        static let tintColor = UIColor(hex: "#FF647C")
    }

    private let window: UIWindow
    private var tabBarController = UITabBarController()
    private let searchConfigurator = SearchConfigurator()

    private lazy var navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let startViewController = searchConfigurator.configure()
        startViewController.navigationItem.title = Localization.Search.title
        let textAttributes = [NSAttributedString.Key.foregroundColor: StyleGuide.Colors.defaultTextColor]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.setViewControllers([startViewController],animated: false)
        navigationController.navigationBar.barTintColor = StyleGuide.Colors.darkGray
        navigationController.navigationBar.prefersLargeTitles = true
        tabBarController.setViewControllers([navigationController], animated: false)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
