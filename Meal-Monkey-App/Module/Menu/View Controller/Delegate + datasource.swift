//
//  Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation
import UIKit

/// Extension for `MenuViewController` to handle
/// `UITableViewDelegate` and `UITableViewDataSource` methods.
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView DataSource
    
    /// Returns the number of rows in the menu section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    /// Configures and returns the cell for a given row at indexPath.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "MenuTableViewCell",
            for: indexPath
        ) as! MenuTableViewCell
        cell.selectionStyle = .none
        cell.configMenu(menu: arrMenu[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    // MARK: - TableView Delegate
    
    /// Handles row selection and navigates based on selected menu item.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrMenu[indexPath.row]
        
        switch selectedItem.intsTag {
        case 0:
            // Navigate to Food list
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                plvc.selectedProductType = .food
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            
        case 1:
            // Navigate to Beverages list
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                plvc.selectedProductType = .Beverages
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            
        case 2:
            // Navigate to Desserts list
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                plvc.selectedProductType = .Desserts
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            
        case 3:
            // Promotions section tapped
            print("Promotions")
            
        default:
            break
        }
    }
}

extension MenuViewController : UITextFieldDelegate
{
    
}
