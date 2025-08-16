//
//  Deletegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import Foundation
import UIKit

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        let product = itemsToShow[indexPath.row]
        cell.configure(with: product)
        
        if pagetype == .Wishlist {
            cell.btnDelete.isHidden = true
            cell.btnLike.isHidden = false
            cell.onDelete = nil
            cell.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.onLike = { [weak self] in
                guard let self = self,
                      let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
                appDelegate.arrWishlist.remove(at: indexPath.row)
                self.tblView.reloadData()
                self.updateUI()
            }
        } else {
            cell.btnDelete.isHidden = false
            cell.btnLike.isHidden = true
            cell.onDelete = { [weak self] in
                guard let self = self,
                      let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
                
                appDelegate.arrCart.remove(at: indexPath.row)
                appDelegate.saveCart()
                self.updateUI()
            }
        }
        return cell
    }
}
