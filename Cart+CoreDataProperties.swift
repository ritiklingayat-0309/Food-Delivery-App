//
//  Cart+CoreDataProperties.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 19/08/25.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var productID: Int32
    @NSManaged public var quantity: Int32
    @NSManaged public var userID: UUID?
    @NSManaged public var user: User?

}

extension Cart : Identifiable {

}
