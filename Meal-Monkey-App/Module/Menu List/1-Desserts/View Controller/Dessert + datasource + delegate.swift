//
//  Dessert + datasource + delegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//


import Foundation
import UIKit

extension DessertsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdesserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        
        switch objFoodType {
        case .food:
            cell.configDessert(dessert : arrdesserts[indexPath.row])
            
        case .Beverages:
            cell.configDessert(dessert : arrdesserts[indexPath.row])
            
        case .Dessert:
            cell.configDessert(dessert : arrdesserts[indexPath.row])
            
        default:
            break
        }
        return cell
    }
}

enum FoodType {
    case Dessert
    case Beverages
    case food
}
