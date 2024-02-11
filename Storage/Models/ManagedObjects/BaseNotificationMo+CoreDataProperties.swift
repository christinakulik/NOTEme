//
//  BaseNotificationMo+CoreDataProperties.swift
//  Storage
//
//  Created by Christina on 1.02.24.
//
//

import Foundation
import CoreData


extension BaseNotificationMo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseNotificationMo> {
        return NSFetchRequest<BaseNotificationMo>(entityName: "BaseNotificationMo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var identifier: String?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var completedDate: Date?

}

extension BaseNotificationMo : Identifiable {

}
