//
//  Dessert + datasource + delegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell",
                                                       for: indexPath) as? DessertsTableViewCell else {
            return UITableViewCell()
        }
        
        let product = filteredProducts[indexPath.row]
        cell.configDessert(dessert: product)
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.row]
        
        // Add product to recent items
        RecentItemsHelper.shared.addProduct(selectedProduct)
        
        // Navigate to ItemDetailsViewController
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let itemDetailsVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            itemDetailsVC.selectedProduct = selectedProduct
            navigationController?.pushViewController(itemDetailsVC, animated: true)
        }
    }
    
    // MARK: - UITextField Delegate (Search)
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            filteredProducts = arrProducts.filter { product in
                product.strProductName.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredProducts = arrProducts
        }
        tblView.reloadData()
    }
}
