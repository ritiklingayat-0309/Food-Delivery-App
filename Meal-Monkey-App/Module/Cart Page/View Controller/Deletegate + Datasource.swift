//
//  Deletegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import Foundation
import UIKit
import CoreData

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arritemsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        guard let product = arritemsToShow[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.configure(with: product)
        
        if pagetype == .Wishlist {
            cell.btnDelete.isHidden = true
            cell.btnLike.isHidden = false
            cell.onDelete = nil
            cell.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.onLike = { [weak self] in
                self?.removeItemFromCoreData(at: indexPath)
                self?.tblView.reloadData()// ⭐ Call the new Core Data removal method
            }
        } else {
            cell.btnDelete.isHidden = false
            cell.btnLike.isHidden = true
            cell.onDelete = { [weak self] in
                self?.removeItemFromCoreData(at: indexPath)
                self?.tblView.reloadData()// ⭐ Call the new Core Data removal method
            }
        }
        return cell
    }
}
