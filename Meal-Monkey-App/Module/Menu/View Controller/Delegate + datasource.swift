//
//  Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation
import UIKit

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.selectionStyle = .none
        cell.configMenu(menu : arrMenu[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 0:
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                plvc.selectedProductType = .food
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Food")
        case 1:
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                plvc.selectedProductType = .Beverages
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("breverges")
        case 2:
            print("Desserts")
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                plvc.selectedProductType = .Desserts
                self.navigationController?.pushViewController(plvc, animated: true)
            }
        case 3:
            print("Promotions")
        default: break
            
        }
    }
}
