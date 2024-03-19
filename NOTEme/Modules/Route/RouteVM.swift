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

}

protocol RouteModuleDelegate: AnyObject {
    var locationDidSet: ((LocationData) -> Void)? { get set }
}

final class RouteVM: RouteViewModelProtocol {
 
    var screenshotDidChanged: ((UIImage?) -> Void)?
    var isSelected: Bool { (screenshot != nil) }
    weak var delegate: RouteModuleDelegate?
    
    private weak var coordinator: RouteCoordinatorProtocol?
    private var adapter: RouteAdapterProtocol
    private lazy var locationManager: CLLocationManager = .init()
    
    private var screenshot: UIImage? {
            didSet
            { screenshotDidChanged?(screenshot) } }
        private let region: MKCoordinateRegion?
    
    init(coordinator: RouteCoordinatorProtocol,
         adapter: RouteAdapterProtocol,
         delegate: RouteModuleDelegate?,
         region: MKCoordinateRegion?) {
        self.coordinator = coordinator
        self.adapter = adapter
        self.delegate = delegate
        self.region = region
        locationManager.requestWhenInUseAuthorization()
    }
    
    func selectDidTap(mapView: MKMapView, captureView: UIView) {
        let center = calculateCenter(for: captureView, in: mapView)
        let radius = calculateRadius(for: captureView, in: mapView)
        let region = mapView.region
        let locationData = LocationData(image: screenshot,
                                        region: region,
                                        center: center,
                                        radius: radius)
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
                         captureView: UIView) {
           let screenshotSize = CGSize(width: mapView.frame.width,
                                     height: captureView.frame.height * 2)
           let origin = CGPoint(x: .zero,
                                y: -(captureView.center.y
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
    
    private func makeCircularRegion(for captureView: UIView,
                                    in mapView: MKMapView,
                                    with id: String) -> CLCircularRegion {
            let center = calculateCenter(for: captureView, in: mapView)
            let radius = calculateRadius(for: captureView, in: mapView)
            let circularRegion = CLCircularRegion(center: center,
                                                  radius: radius,
                                                  identifier: id)
            return circularRegion
        }
        
        private func calculateRadius(for captureView: UIView,
                                     in mapView: MKMapView) -> CLLocationDistance {
            let mapRegion = mapView.convert(captureView.bounds,
                                            toRegionFrom: captureView)
            let centerPoint = CLLocation(latitude: mapRegion.center.latitude,
                                         longitude: mapRegion.center.longitude)
            let topPoint = CLLocation(
                latitude: mapRegion.center.latitude - mapRegion.span.latitudeDelta/2,
                longitude: mapRegion.center.longitude)
            let radius = centerPoint.distance(from: topPoint)
            return radius
        }
        
        private func calculateCenter(for captureView: UIView,
                                     in mapView: MKMapView) ->  CLLocationCoordinate2D {
            let mapRegion = mapView.convert(captureView.bounds,
                                            toRegionFrom: captureView)
            return mapRegion.center
        }
}
