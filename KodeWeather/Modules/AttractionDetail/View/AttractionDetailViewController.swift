//
//  AttractionDetailViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 23.10.2020.
//

import UIKit
import MapKit

final class AttractionDetailViewController: UIViewController {

    // MARK: - Properties

    var output: AttractionDetailViewOutput?

    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()

    private let mapView = MKMapView()

    private let attractionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let attractionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: ViewOptions.attractionTitleFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        return label
    }()

    private let attractionDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: ViewOptions.attractionDescriptionFontSize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.numberOfLines = 3
        return label
    }()

    private let mapTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: ViewOptions.mapTitleFontsize)
        label.textColor = StyleGuide.Colors.defaultTextColor
        return label
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
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(attractionImageView)
        scrollContentView.addSubview(attractionTitle)
        scrollContentView.addSubview(attractionDescription)
        scrollContentView.addSubview(mapView)
        scrollContentView.addSubview(mapTitle)

        view.addSubview(mapView)
        mapView.isUserInteractionEnabled = false
        mapView.delegate = self
    }


    private func setupLayouts() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        attractionImageView.translatesAutoresizingMaskIntoConstraints = false
        attractionTitle.translatesAutoresizingMaskIntoConstraints = false
        attractionDescription.translatesAutoresizingMaskIntoConstraints = false
        mapTitle.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            attractionImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            attractionImageView.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            attractionImageView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            attractionTitle.topAnchor.constraint(equalTo: attractionImageView.bottomAnchor),
            attractionTitle.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            attractionTitle.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
        ])

        NSLayoutConstraint.activate([
            attractionDescription.topAnchor.constraint(equalTo: attractionTitle.bottomAnchor),
            attractionDescription.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            attractionDescription.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
        ])


        NSLayoutConstraint.activate([
            mapTitle.topAnchor.constraint(equalTo: attractionDescription.bottomAnchor),
            mapTitle.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            mapTitle.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
        ])


        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: mapTitle.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200),
        ])


        attractionImageView.image = UIImage(named: "Build")
        attractionTitle.text = "Музей естественных наук"
        attractionDescription.text = "Tempus at pharetra ipsum vel eleifend non vestibulum ac, tristique. Malesuada ac viverra blandit at vitae tellus sit tempus sem eu.Tempus at pharetra ipsum vel eleifend non vestibulum ac, tristique. Malesuada ac viverra blandit at vitae tellus sit tempus sem euTempus at pharetra ipsum vel eleifend non vestibulum ac, tristique. Malesuada ac viverra blandit at vitae tellus sit tempus sem euTempus at pharetra ipsum vel eleifend non vestibulum ac, tristique. Malesuada ac viverra blandit at vitae tellus sit tempus sem eu"
    }
}

//MARK: - AttractionDetailViewInput
extension AttractionDetailViewController: AttractionDetailViewInput {

}

// MARK: - MKMapViewDelegate

extension AttractionDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationReuseIdentifier = "anotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseIdentifier)
        }
        annotationView?.image = UIImage(named: "mapPin")
        annotationView?.centerOffset =  CGPoint(x: 0, y: -(annotationView?.frame.height ?? 0)/2)
        return annotationView
    }
}

//MARK: - Constants
extension AttractionDetailViewController {
    private enum ViewOptions {
        static let attractionTitleFontSize: CGFloat = 32
        static let attractionDescriptionFontSize: CGFloat = 16
        static let mapTitleFontsize: CGFloat = 24
    }
}


