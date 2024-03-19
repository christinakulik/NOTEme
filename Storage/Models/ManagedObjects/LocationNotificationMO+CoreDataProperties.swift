//
//  LocationNotificationMO+CoreDataProperties.swift
//  Storage
//
//  Created by Christina on 13.03.24.
//
//

import Foundation
import CoreData


extension LocationNotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationNotificationMO> {
        return NSFetchRequest<LocationNotificationMO>(entityName: "LocationNotificationMO")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var deltalLongitude: Double
    @NSManaged public var deltaLatitutde: Double
    @NSManaged public var imagePath: String?

}
