//
//  AttcartionDetailFullMapViewController.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 25.10.2020.
//

import Foundation

import UIKit
import MapKit

final class AttcartionDetailFullMapViewController: UIViewController {

    private let mapView = MKMapView()

    convenience init(with location: Location) {
        self.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StyleGuide.Colors.darkGray
        setupViews()
        setupLayouts()
    }

    private func setupViews() {
        view.addSubview(mapView)
        mapView.isUserInteractionEnabled = true
        mapView.delegate = self
    }


    private func setupLayouts() {
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureMap(lan: Double, lon: Double) {
        let cooridnate = CLLocationCoordinate2D(latitude: lan, longitude: lon)
        let coordinateRegion = MKCoordinateRegion(center: cooridnate, span: MKCoordinateSpan(latitudeDelta: ViewOptions.mapDelta, longitudeDelta: ViewOptions.mapDelta))
        mapView.setRegion(coordinateRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = cooridnate
        mapView.addAnnotation(annotation)
    }
}

extension AttcartionDetailFullMapViewController: MKMapViewDelegate {
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
extension AttcartionDetailFullMapViewController {
    private enum ViewOptions {
        static let mapDelta: Double = 0.03
    }
}

