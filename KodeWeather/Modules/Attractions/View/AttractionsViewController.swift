//
//  AttractionsViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//


import UIKit

final class AttractionsViewController: UIViewController {

    // MARK: - Properties

    var output: AttractionsViewOutput?

    let attractionsCollectionView : UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupLayouts()
    }

    private func setupViews() {
        view.addSubview(attractionsCollectionView)
    }


    private func setupLayouts() {
        attractionsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            attractionsCollectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            attractionsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            attractionsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            attractionsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - AttractionsViewInput
extension AttractionsViewController: AttractionsViewInput {

}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension AttractionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }


}
