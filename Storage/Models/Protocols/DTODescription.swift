//
//  DTODescription.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation
import CoreData

public protocol MODescription: NSManagedObject, NSFetchRequestResult {
    var identifier: String? { get }
    
    func apply(dto: any DTODescription)
    func toDTO() -> (any DTODescription)?
}

public protocol DTODescription {
    associatedtype MO: MODescription
    
    var identifier: String { get set }
    var date: Date { get set }
    var title: String { get set }
    var subtitle: String? { get set }
    var completedDate: Date? { get set }
    
    static func fromMO(_ mo: MO) -> Self?
    
    func createMO(context: NSManagedObjectContext) -> MO?
}
