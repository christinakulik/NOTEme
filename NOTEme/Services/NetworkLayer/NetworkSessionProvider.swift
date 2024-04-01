//
//  NetworkSessionProvider.swift
//  NOTEme
//
//  Created by Christina on 19.03.24.
//

import Foundation

final class NetworkSessionProvider {
    
    func send<Request: NetworkRequest>(
        request: Request,
        completion: @escaping (Request.ResponseModel?) -> Void
    ) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        URLSession.shared.dataTask(with: urlRequest) {
            responseData, response, error in
            if let error {
                print("[NetworkLayer]: Error -", error.localizedDescription)
                completion(nil)
            } else if let responseData,
                      let responseModel =
                        try? JSONDecoder().decode(Request.ResponseModel.self,
                                                  from: responseData) {
                completion(responseModel)
            } else {
                print("[NetworkLayer]: Decode error type \(Request.ResponseModel.self)")
                completion(nil)
            }
        }.resume()
    }
    
}
