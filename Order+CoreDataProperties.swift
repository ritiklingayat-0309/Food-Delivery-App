//
//  Order+CoreDataProperties.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 19/08/25.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var orderDate: Date?
    @NSManaged public var orderID: UUID?
    @NSManaged public var totalAmount: Double
    @NSManaged public var userID: UUID?
    @NSManaged public var orderedItems: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for orderedItems
extension Order {

    @objc(addOrderedItemsObject:)
    @NSManaged public func addToOrderedItems(_ value: OrderedItem)

    @objc(removeOrderedItemsObject:)
    @NSManaged public func removeFromOrderedItems(_ value: OrderedItem)

    @objc(addOrderedItems:)
    @NSManaged public func addToOrderedItems(_ values: NSSet)

    @objc(removeOrderedItems:)
    @NSManaged public func removeFromOrderedItems(_ values: NSSet)

}

extension Order : Identifiable {

}
