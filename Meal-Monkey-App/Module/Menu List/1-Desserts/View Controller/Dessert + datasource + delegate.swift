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
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        let product = arrProducts[indexPath.row]
        cell.configDessert(dessert: product)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle:nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController{
            let selectedProduct = arrProducts[indexPath.row]
            secondVc.selectedProduct = selectedProduct
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}

