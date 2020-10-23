//
//  AttractionDetailViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import UIKit

final class AttractionDetailViewController: UIViewController {

    // MARK: - Properties

    var output: AttractionDetailViewOutput?

    private let scrollView = UIScrollView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupLayouts()
    }

    private func setupViews() {
        view.addSubview(scrollView)
    }


    private func setupLayouts() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
    }
}

//MARK: - AttractionDetailViewInput
extension AttractionDetailViewController: AttractionDetailViewInput {

}
