//
//  DTODescription.swift
//  Storage
//
//  Created by Christina on 7.02.24.
//

import Foundation
import CoreData

public protocol MODescription: NSManagedObject {
    associatedtype DTO: DTODescription
    func apply(dto: DTO)
}


public protocol DTODescription {
    associatedtype DTO
    associatedtype MO: MODescription
    
    init?(mo: MO)
}
