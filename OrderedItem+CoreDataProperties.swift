//
//  OrderedItem+CoreDataProperties.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 19/08/25.
//
//

import Foundation
import CoreData


extension OrderedItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderedItem> {
        return NSFetchRequest<OrderedItem>(entityName: "OrderedItem")
    }

    @NSManaged public var orderedItemID: UUID?
    @NSManaged public var orderID: UUID?
    @NSManaged public var productID: Int32
    @NSManaged public var quantity: Int32
    @NSManaged public var priceAtTimeOfOrder: Double
    @NSManaged public var order: Order?
    @NSManaged public var product: Product?

}

extension OrderedItem : Identifiable {

}
