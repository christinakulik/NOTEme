//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation

public struct LocationNotificationDTO: DTODescription {
 
    public typealias DTO = Self
    public typealias MO = LocationNotificationMO
    
    public var date: Date
    public var identifier: String
    public var title: String
    public var subtitle: String?
    public var completedDate: Date?
    public var longitude: Double
    public var latitude: Double
    
    public init(date: Date,
                identifier: String,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                longitude: Double,
                latitude: Double) {
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.longitude = longitude
        self.latitude = latitude
    }
    
    public init?(mo: LocationNotificationMO) {
        guard
            let identifier = mo.identifier,
            let title = mo.title,
            let date = mo.date
        else { return nil }
        
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = mo.subtitle
        self.completedDate = mo.completedDate
        self.longitude = mo.longitude
        self.latitude = mo.latitude
    }
}
