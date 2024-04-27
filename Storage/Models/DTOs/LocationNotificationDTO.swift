//
//  LocationNotificationDTO.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation
import CoreData

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
    public var deltalLongitude: Double
    public var deltaLatitutde: Double
    public var imagePath: String
    
    public init(date: Date,
                identifier: String = UUID().uuidString,
                title: String,
                subtitle: String? = nil,
                completedDate: Date? = nil,
                longitude: Double,
                latitude: Double,
                deltalLongitude: Double,
                deltaLatitutde: Double,
                imagePath: String) {
        self.date = date
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.completedDate = completedDate
        self.longitude = longitude
        self.latitude = latitude
        self.deltalLongitude = deltalLongitude
        self.deltaLatitutde = deltaLatitutde
        self.imagePath = imagePath
    }
   
    
    public static func fromMO(_ mo: LocationNotificationMO)
    -> LocationNotificationDTO? {
        guard
            let identifier = mo.identifier,
            let title = mo.title,
            let date = mo.date,
            let imagePath = mo.imagePath
        else { return nil }
        
        return LocationNotificationDTO(date: date, 
                                       identifier: identifier,
                                       title: title,
                                       subtitle: mo.subtitle,
                                       completedDate: mo.completedDate,
                                       longitude: mo.longitude,
                                       latitude: mo.latitude,
                                       deltalLongitude: mo.deltalLongitude,
                                       deltaLatitutde: mo.deltaLatitutde,
                                       imagePath: imagePath)
    }
    
    public func createMO(context: NSManagedObjectContext) -> LocationNotificationMO? {
        let mo = LocationNotificationMO(context: context)
        mo.apply(dto: self)
        return mo
    }
}
