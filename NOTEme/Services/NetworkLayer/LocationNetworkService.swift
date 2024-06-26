//
//  LocationNetworkService.swift
//  NOTEme
//
//  Created by Christina on 19.03.24.
//

import Foundation
import CoreLocation

final class LocationNetworkService {
    
    private let session = NetworkSessionProvider()
    
    func getNearBy(coordinates: CLLocationCoordinate2D,
                   completion: @escaping ([NearByResponseModel.Result]) -> Void) {
        let requestModel = NearByRequestModel(coordinates: coordinates)
        let request = NearByRequest(model: requestModel)
        session.send(request: request) { response in
            completion(response?.results ?? [])
        }
    }
    
    func getSearchPlaces(coordinates: CLLocationCoordinate2D,
                      query: String,
                      completion: @escaping ([SearchPlacesResponseModel.Result]) 
                      -> Void) {
        let requestModel = SearchPlacesRequestModel(coordinates: coordinates,
                                                    query: query)
        let request = SearchPlacesRequest(model: requestModel)
        session.send(request: request) { response in
            completion(response?.results ?? [])
        }
    }
}
