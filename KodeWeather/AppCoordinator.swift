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

    let attractionService = AttractionService()

    private let window: UIWindow
    private var tabBarController = UITabBarController()
    private let searchConfigurator = SearchConfigurator()

    private lazy var navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
        window.backgroundColor = StyleGuide.Colors.darkGray
    }

    private func setupGlobal() {
        UITextField.appearance().keyboardAppearance = .dark
    }

    func start() {
        CoreDataService.instance.clearData()
        attractionService.loadAttractionsFromJson()
        setupGlobal()
        let startViewController = searchConfigurator.configure()
        startViewController.navigationItem.title = Localization.Search.title
        let textAttributes = [NSAttributedString.Key.foregroundColor: StyleGuide.Colors.defaultTextColor]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.setViewControllers([startViewController],animated: false)
        navigationController.navigationBar.barTintColor = StyleGuide.Colors.darkGray
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.prefersLargeTitles = true
        tabBarController.tabBar.barTintColor = StyleGuide.Colors.darkGray
        tabBarController.tabBar.isTranslucent = false
        tabBarController.setViewControllers([navigationController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
