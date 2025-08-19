//
//  Product+CoreDataProperties.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 19/08/25.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var category: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String?
    @NSManaged public var productID: Int32
    @NSManaged public var productType: String?
    @NSManaged public var rating: Double
    @NSManaged public var totalRatings: Int32

}

extension Product : Identifiable {

}
