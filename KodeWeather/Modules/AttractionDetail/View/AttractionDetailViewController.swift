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

    private var imageHeightAnchor:NSLayoutConstraint = NSLayoutConstraint()


    private let attractionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let attractionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: ViewOptions.attractionTitleFontSize, weight: .heavy)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.numberOfLines = 0
        return label
    }()

    private let mapTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: ViewOptions.mapTitleFontsize, weight: .semibold)
        label.textColor = StyleGuide.Colors.defaultTextColor
        label.text = Localization.AttractionDetail.mapTitle
        return label
    }()

    private let attractionDescription = AttractionDescriptionView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        view.backgroundColor = StyleGuide.Colors.darkGray
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

        mapView.delegate = self
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(mapTapped))
        mapView.addGestureRecognizer(gestureRecognizer)

        let scrollViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))

        scrollViewPanGesture.delegate = self
        scrollView.addGestureRecognizer(scrollViewPanGesture)
        scrollView.bounces = false
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

        imageHeightAnchor = attractionImageView.heightAnchor.constraint(equalToConstant: ViewOptions.imageMinSize)
        imageHeightAnchor.isActive = true


        NSLayoutConstraint.activate([
            attractionTitle.topAnchor.constraint(equalTo: attractionImageView.bottomAnchor, constant: LayoutOptions.titlePadding),
            attractionTitle.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor, constant: LayoutOptions.titlePadding),
            attractionTitle.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor, constant: -LayoutOptions.titlePadding),
        ])

        NSLayoutConstraint.activate([
            attractionDescription.topAnchor.constraint(equalTo: attractionTitle.bottomAnchor, constant: LayoutOptions.descriptionTopPadding),
            attractionDescription.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            attractionDescription.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
        ])


        NSLayoutConstraint.activate([
            mapTitle.topAnchor.constraint(equalTo: attractionDescription.bottomAnchor, constant: LayoutOptions.mapTitleTopPadding),
            mapTitle.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor, constant: LayoutOptions.textHorizontalPadding),
            mapTitle.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor, constant: LayoutOptions.textHorizontalPadding),
        ])


        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: mapTitle.bottomAnchor, constant: LayoutOptions.mapViewTopPadding),
            mapView.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            mapView.heightAnchor.constraint(equalToConstant: LayoutOptions.mapHeight),
        ])
    }
}

//MARK: - AttractionDetailViewInput
extension AttractionDetailViewController: AttractionDetailViewInput {
    func configure(images: [String], title: String, description: String, fullDescription: String) {
        attractionImageView.setImage(with: URL(string: images[0]))
        attractionTitle.text = title
        attractionDescription.configure(desc: description, fullDesc: fullDescription)
    }

    func configureMap(lan: Double, lon: Double) {
        let cooridnate = CLLocationCoordinate2D(latitude: lan, longitude: lon)
        let coordinateRegion = MKCoordinateRegion(center: cooridnate, span: MKCoordinateSpan(latitudeDelta: ViewOptions.mapDelta, longitudeDelta: ViewOptions.mapDelta))
        mapView.setRegion(coordinateRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = cooridnate
        mapView.addAnnotation(annotation)
    }

    func configureTitle(title: String?) {
        navigationItem.title = title
    }
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


//MARK:- UI Actions

extension AttractionDetailViewController {
    @objc func mapTapped() {
        output?.mapTapped()
    }

    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let velocity = gesture.velocity(in: view)
            if  imageHeightAnchor.constant < ViewOptions.imageMaxSize && velocity.y > 0{
                imageHeightAnchor.constant += ViewOptions.heightChangeIteration
            } else if imageHeightAnchor.constant > ViewOptions.imageMinSize && velocity.y < 0{
                imageHeightAnchor.constant -= ViewOptions.heightChangeIteration
            }
        default:
            return
        }
    }
}


//MARK:- UIGestureRecognizerDelegate

extension  AttractionDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: - Constants
extension AttractionDetailViewController {
    private enum ViewOptions {
        static let attractionTitleFontSize: CGFloat = 32
        static let attractionDescriptionFontSize: CGFloat = 16
        static let mapTitleFontsize: CGFloat = 24
        static let mapDelta: Double = 0.03
        static let imageMaxSize: CGFloat = 400
        static let imageMinSize: CGFloat = 200
        static let heightChangeIteration: CGFloat = 20
    }

    private enum LayoutOptions {
        static let mapHeight: CGFloat = 214
        static let titlePadding: CGFloat = 24
        static let textHorizontalPadding: CGFloat = 24
        static let descriptionTopPadding: CGFloat = 14
        static let mapTitleTopPadding: CGFloat = 32
        static let mapViewTopPadding: CGFloat = 16
    }
}


