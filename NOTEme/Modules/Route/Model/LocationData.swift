//
//  LocationData.swift
//  NOTEme
//
//  Created by Christina on 12.03.24.
//

import UIKit
import MapKit

struct LocationData {
    let image: UIImage?
    let region: MKCoordinateRegion
    let center: CLLocationCoordinate2D
    let radius: CLLocationDistance
}
