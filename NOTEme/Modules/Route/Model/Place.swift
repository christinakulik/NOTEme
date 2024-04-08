//
//  Place.swift
//  NOTEme
//
//  Created by Christina on 26.03.24.
//

import UIKit
import CoreLocation

struct Place {
    let name: String
    let coordinate: CLLocationCoordinate2D
    let distance: Int
    
    init(result: NearByResponseModel.Result) {
            self.name = result.name
            self.distance = result.distance
            self.coordinate = .init(
                latitude: result.geocodes.main.latitude,
                longitude: result.geocodes.main.longitude
            )
        }
        
        init(result: SearchPlacesResponseModel.Result) {
            self.name = result.name
            self.distance = result.distance
            self.coordinate = .init(
                latitude: result.geocodes.main.latitude,
                longitude: result.geocodes.main.longitude
            )
        }
}
