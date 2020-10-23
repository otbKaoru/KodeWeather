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

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupLayouts()
    }

    private func setupViews() {
    }


    private func setupLayouts() {
    }
}

//MARK: - AttractionDetailViewInput
extension AttractionDetailViewController: AttractionDetailViewInput {

}
