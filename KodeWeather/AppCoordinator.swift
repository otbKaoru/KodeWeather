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
    private var tabBarController = CustomTabBarController()
    private let searchConfigurator = SearchConfigurator()

    private lazy var navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
        window.backgroundColor = StyleGuide.Colors.darkGray
    }

    private func setupGlobal() {
        UITextField.appearance().keyboardAppearance = .dark
        UserDefaults.standard.set(["RU"], forKey: "AppleLanguages")
    }

    private func setupNavigationController() {
        let startViewController = searchConfigurator.configure()
        startViewController.navigationItem.title = Localization.Search.title
        let textAttributes = [NSAttributedString.Key.foregroundColor: StyleGuide.Colors.defaultTextColor]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.setViewControllers([startViewController],animated: false)
        navigationController.navigationBar.barTintColor = StyleGuide.Colors.darkGray
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = StyleGuide.Colors.defaultTextColor
    }

    private func setupTabBarConroller() {
        tabBarController.tabBar.barTintColor = StyleGuide.Colors.darkGray
        tabBarController.tabBar.isTranslucent = false
        tabBarController.setViewControllers([navigationController], animated: false)
    }

    private func setupAttractionsData() {
        attractionService.loadAttractionsFromJson()
    }

    func start() {
        setupAttractionsData()
        setupGlobal()
        setupNavigationController()
        setupTabBarConroller()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

