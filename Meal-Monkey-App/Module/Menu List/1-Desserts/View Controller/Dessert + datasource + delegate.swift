//
//  Dessert + datasource + delegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//


import Foundation
import UIKit

extension DessertsViewController : UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        let product = filteredProducts[indexPath.row]
        cell.configDessert(dessert: product)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.row]
        RecentItemsHelper.shared.addProduct(selectedProduct)
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle:nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController{
            let selectedProduct = filteredProducts[indexPath.row]
            secondVc.selectedProduct = selectedProduct
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            filteredProducts = arrProducts.filter { product in
                return product.strProductName.lowercased().contains(searchText.lowercased())
            }
        } else {

            filteredProducts = arrProducts
        }
    
        tblView.reloadData()
    }
}


