//
//  delgate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import Foundation
import UIKit

/// Extension to handle UITableView delegate and data source methods
/// for the `MoreViewController`.
extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    /// Returns the number of rows in the "More" list.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMore.count
    }
    
    /// Configures and returns the table view cell for a given index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "MoreTableViewCell",
            for: indexPath
        ) as! MoreTableViewCell
        
        // Fetch the data object
        let obj = arrMore[indexPath.row]
        
        // Configure the cell with "More" data
        cell.configMoreData(more: obj)
    
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    /// Handles selection of rows in the "More" table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrMore[indexPath.row]
        
        switch selectedItem.intsTag {
            
        case 0: // Payment Details
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentDetailsViewController") as? PaymentDetailsViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case 1: // Order List
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "OrderListViewController") as? OrderListViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case 2: // Notifications
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                vc.objPageType = .Notification
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case 3: // Inbox
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                vc.objPageType = .Inbox
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case 4: // About Us
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                vc.objPageType = .About
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case 5: // Wishlist
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
                vc.pagetype = .Wishlist
                navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            print("Other row selected")
        }
    }
}

/// Enum used to represent different pages within the "More" section.
enum PageType {
    case PaymentDetails
    case MyOrder
    case Notification
    case Inbox
    case About
    case Wishlist
    case Cart
}
