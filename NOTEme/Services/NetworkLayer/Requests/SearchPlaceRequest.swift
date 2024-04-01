//
//  SearchLocationRequest.swift
//  NOTEme
//
//  Created by Christina on 26.03.24.
//

import Foundation
import CoreLocation

struct SearchPlacesResponseModel: Decodable {
    struct Result: Decodable {
        
        struct Geocodes: Decodable {
            struct Main: Decodable {
                let latitude: Double
                let longitude: Double
            }
            let main: Main
        }
        
        struct Location: Decodable {
            let address: String
            
            enum CodingKeys: String, CodingKey {
                case address = "formatted_address"
            }
        }
        
        let distance: Int
        let geocodes: Geocodes
        let location: Location
        let name: String
    }
    let results: [Result]
}

struct SearchPlacesRequestModel {
    let coordinates: CLLocationCoordinate2D
    let query: String
}

struct SearchPlacesRequest: NetworkRequest {
    typealias ResponseModel = SearchPlacesResponseModel
    
    var url: URL {
        let baseUrl = ApiPaths.searchPlaces
        let ll = "\(model.coordinates.latitude),\(model.coordinates.longitude)"
        let parameters = "ll=\(ll)&query=\(model.query)"
        return URL(string: baseUrl+"?"+parameters)!
    }
    var method: NetworkHTTPMethod { .get }
    var headers: [String : String] {
        ["Authorization": ApiToken.fourSquareToken]
    }
    let model: SearchPlacesRequestModel
    var body: Data? { nil }
}
