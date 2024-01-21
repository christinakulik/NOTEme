//
//  Container.swift
//  NOTEme
//
//  Created by Christina on 16.01.24.
//

import Foundation

final class Container {
    
    private var container: [String: Any] = [:]
    
//    func register(_ service: Any) {
//        container["\type(of: service).self"] = service
//    }
    
    func register<Type: Any>(_ service: Type) {
        container["\(Type.self)"] = service
    }
    
    func resolve<Type: Any>() -> Type {
        return container["\(Type.self)"] as! Type
    }
}
