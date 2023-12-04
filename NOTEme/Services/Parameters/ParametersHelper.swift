//
//  ParametersHelper.swift
//  NOTEme
//
//  Created by Christina on 28.11.23.
//

import Foundation


final class ParametersHelper {
    
    enum ParameterKey: String {
        case authenticated
        case onboarded
        case main
    }
    
    private static var ud: UserDefaults = .standard
    
    private init() {}
    
    static func set(_ key: ParameterKey, value: Bool) {
        ud.setValue(value, forKey: key.rawValue)
    }
    
    static func get(_ key: ParameterKey) -> Bool {
        return ud.bool(forKey: key.rawValue)
    }
    
}
