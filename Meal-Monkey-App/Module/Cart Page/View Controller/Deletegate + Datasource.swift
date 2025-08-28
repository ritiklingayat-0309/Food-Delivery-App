//
//  Deletegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import Foundation
import UIKit
import CoreData

/// Extension for `CartViewController` to conform to UITableViewDelegate and UITableViewDataSource
extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows in the table view based on the items to show
    /// - Parameters:
    ///   - tableView: The UITableView requesting this information
    ///   - section: Section index
    /// - Returns: Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arritemsToShow.count
    }
    
    /// Returns the cell for a given index path
    /// Configures the cell based on whether it is displayed in Wishlist or Cart page
    /// - Parameters:
    ///   - tableView: The UITableView requesting the cell
    ///   - indexPath: IndexPath of the cell
    /// - Returns: Configured UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        // Get product safely
        guard let product = arritemsToShow[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(with: product)
        
        // Configure cell based on page type
        if pagetype == .Wishlist {
            cell.lblQuntity.isHidden = true
            cell.btnDelete.isHidden = true
            cell.btnLike.isHidden = false
            cell.onDelete = nil
            cell.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.onLike = { [weak self] in
                self?.removeItemFromCoreData(at: indexPath)
                self?.tblView.reloadData()
            }
        } else {
            cell.btnDelete.isHidden = false
            cell.btnLike.isHidden = true
            cell.onDelete = { [weak self] in
                self?.removeItemFromCoreData(at: indexPath)
                self?.tblView.reloadData()
            }
        }
        return cell
    }
}
