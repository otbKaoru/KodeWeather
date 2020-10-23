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

    let attractionsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
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
        attractionsCollectionView.backgroundColor = StyleGuide.Colors.darkGray
        attractionsCollectionView.delegate = self
        attractionsCollectionView.dataSource = self
        attractionsCollectionView.register(AttractionsCollectionViewCell.self, forCellWithReuseIdentifier: AttractionsCollectionViewCell.reuseIdentifier)
        attractionsCollectionView.contentInset = UIEdgeInsets(top: ViewOptions.contentInset,
                                                              left: ViewOptions.contentInset,
                                                              bottom: ViewOptions.contentInset,
                                                              right: ViewOptions.contentInset)
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
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionsCollectionViewCell.reuseIdentifier, for: indexPath) as! AttractionsCollectionViewCell
        cell.configure(image: UIImage(named: "Build"),
                       title: "Музей естественных наук",
                       description: "Tempus at pharetra ipsum vel eleifend non vestibulum ac, tristique. Malesuada ac viverra blandit at vitae tellus sit tempus sem eu.")
        return cell
    }
}

extension AttractionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-ViewOptions.contentInset*2, height: view.frame.height/4)
    }
}

//MARK: - Constatnts

extension AttractionsViewController {
    private enum ViewOptions {
        static let contentInset: CGFloat = 16
    }
}
