//
//  RouteVM.swift
//  NOTEme
//
//  Created by Christina on 10.03.24.
//

import UIKit
import Storage
import MapKit

protocol RouteCoordinatorProtocol: AnyObject {
    func finish()
}

protocol RouteAdapterProtocol {
    var didSelectRow: ((Place) -> Void)? { get set }
    func reloadData(with rows: [Place])
    func makeTableView() -> UITableView
}

protocol RouteModuleDelegate: AnyObject {
    var locationDidSet: ((LocationData) -> Void)? { get set }
    func didFindNearbyPlaces(_ results: [NearByResponseModel.Result])
}

final class RouteVM: RouteViewModelProtocol {
    var locationDidSelect: ((CLLocationCoordinate2D) -> Void)?
 
    var screenshotDidChanged: ((UIImage?) -> Void)?
    var isSelected: Bool { (screenshot != nil) }
    weak var delegate: RouteModuleDelegate?
    
    private weak var coordinator: RouteCoordinatorProtocol?
    private var adapter: RouteAdapterProtocol
    private var places: [Place] = []
    private var locationNetworkService: LocationNetworkService
    private lazy var locationManager: CLLocationManager = .init()
    
    private var screenshot: UIImage? {
            didSet
            { screenshotDidChanged?(screenshot) } }
        private let region: MKCoordinateRegion?
    
    init(coordinator: RouteCoordinatorProtocol,
         adapter: RouteAdapterProtocol,
         delegate: RouteModuleDelegate?,
         locationNetworkService: LocationNetworkService,
         region: MKCoordinateRegion?) {
        self.coordinator = coordinator
        self.adapter = adapter
        self.delegate = delegate
        self.locationNetworkService = locationNetworkService
        self.region = region
        locationManager.requestWhenInUseAuthorization()
    }
    
    func makeTableView() -> UITableView {
           adapter.makeTableView()
       }
    
    func searchForNearbyPlaces(coordinate: CLLocationCoordinate2D) {
            locationNetworkService.getNearBy(coordinates: coordinate) { 
                [weak self] (results: [NearByResponseModel.Result]) in
                DispatchQueue.main.async {
                    self?.delegate?.didFindNearbyPlaces(results)
                }
            }
        }
    
    func selectDidTap(mapView: MKMapView, regionView: UIView) {
        let center = calculateCenter(for: regionView, in: mapView)
        let radius = calculateRadius(for: regionView, in: mapView)
        let region = mapView.region
        let circleRegion = makeCircularRegion(for: regionView, in: mapView,
                                              with: UUID().uuidString)
        let locationData = LocationData(image: screenshot,
                                        region: region,
                                        center: center,
                                        radius: radius,
                                        circularRegion: circleRegion)
       delegate?.locationDidSet?(locationData)
       coordinator?.finish()
    }
    
    func cancelDidTap() {
        if screenshot != nil {
            self.screenshot = nil
        } else {
            coordinator?.finish()
        }
    }
    
    func setDefaultMapPosition(for mapView: MKMapView) {
           
           if let region {
               mapView.setRegion(region, animated: true)
           } else {
               if let userLocation = locationManager.location?.coordinate {
                   let viewRegion = MKCoordinateRegion(center: userLocation,
                                                       latitudinalMeters: 1000,
                                                       longitudinalMeters: 1000)
                   mapView.setRegion(viewRegion, animated: true)
               }
           }
       }
    
    func makeScreenshot(_ view: UIView,
                         mapView: MKMapView,
                         regionView: UIView) {
           let screenshotSize = CGSize(width: mapView.frame.width,
                                     height: regionView.frame.height * 2)
           let origin = CGPoint(x: .zero,
                                y: -(regionView.center.y
                                     - screenshotSize.height / 2))
           let contentRect = CGRect(origin: origin, size: view.bounds.size)
           
           UIGraphicsBeginImageContextWithOptions(screenshotSize,
                                                  false,
                                                  UIScreen.main.scale)
           
           view.drawHierarchy(in: contentRect, afterScreenUpdates: false)
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           self.screenshot = image
       }
    
    private func makeCircularRegion(for regionView: UIView,
                                    in mapView: MKMapView,
                                    with id: String) -> CLCircularRegion {
            let center = calculateCenter(for: regionView, in: mapView)
            let radius = calculateRadius(for: regionView, in: mapView)
            let circularRegion = CLCircularRegion(center: center,
                                                  radius: radius,
                                                  identifier: id)
            return circularRegion
        }
        
        private func calculateRadius(for regionView: UIView,
                                     in mapView: MKMapView)
    -> CLLocationDistance {
            let mapRegion = mapView.convert(regionView.bounds,
                                            toRegionFrom: regionView)
            let centerPoint = CLLocation(latitude: mapRegion.center.latitude,
                                         longitude: mapRegion.center.longitude)
            let topPoint = CLLocation(
                latitude: mapRegion.center.latitude - mapRegion.span.latitudeDelta/2,
                longitude: mapRegion.center.longitude)
            let radius = centerPoint.distance(from: topPoint)
            return radius
        }
        
        private func calculateCenter(for regionView: UIView,
                                     in mapView: MKMapView)
    ->  CLLocationCoordinate2D {
            let mapRegion = mapView.convert(regionView.bounds,
                                            toRegionFrom: regionView)
            return mapRegion.center
        }
    
    private func getNearBy() {
            guard let userLocation = locationManager.location?.coordinate else { return }
            locationNetworkService.getNearBy(coordinates: userLocation) { [weak self] result in
                DispatchQueue.main.async {
                    self?.places =  result.compactMap { Place(result: $0) }
                    self?.adapter.reloadData(with: self?.places ?? [])
                }
            }
        }
    
    func searchPlaces(for query: String) {
                guard let userLocation = locationManager.location?.coordinate else { return }
                locationNetworkService.searchPlaces(for: query, with: userLocation) { [weak self] result in
                    DispatchQueue.main.async {
                        self?.places = result
                            .compactMap { Place(result: $0) }
                            .sorted { $0.distance < $1.distance }
                        self?.adapter.reloadData(with: self?.places ?? [])
                    }
                }
            }
        
}
