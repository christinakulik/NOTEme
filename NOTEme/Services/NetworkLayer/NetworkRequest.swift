//
//  NetwirkRequest.swift
//  NOTEme
//
//  Created by Christina on 19.03.24.
//

import Foundation

enum NetworkHTTPMethod: String {
    case get = "GET"
}

protocol NetworkRequest {
    
    associatedtype ResponseModel: Decodable
    
    var url: URL { get }
    var method: NetworkHTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}
