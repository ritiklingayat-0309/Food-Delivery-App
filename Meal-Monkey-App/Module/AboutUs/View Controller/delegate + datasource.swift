//
//  delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation
import UIKit

/**
 An extension to `AboutUsViewController` to conform to the `UITableViewDelegate` and `UITableViewDataSource` protocols.
 
 This extension handles the data and presentation logic for the table view, dynamically configuring cells based on the current page type.
 */
extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    
    /**
     Determines the number of rows to display in the table view.
     
     - Parameter tableView: The table view requesting this information.
     - Parameter section: An index number identifying a section in the table view.
     - Returns: The number of items in the `currentData` array.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrcurrentData.count
    }
    
    /**
     Configures and returns a table view cell for a specified row.
     
     The cell's appearance is determined by the `objPageType` property, which selects the appropriate configuration method on the `AboutUsTableViewCell`.
     
     - Parameters:
        - tableView: The table view requesting the cell.
        - indexPath: An index path that specifies the location of the row.
     - Returns: A configured `AboutUsTableViewCell` instance.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AboutUsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        
        switch objPageType {
        case .About:
            cell.configaboutcell(about: arrcurrentData[indexPath.row])
            
        case .Notification:
            cell.configNotificationcell(about: arrcurrentData[indexPath.row])
            
        case .Inbox:
            cell.configInboxcell(about: arrcurrentData[indexPath.row])
            
        default:
            break
        }
        return cell
    }
}
