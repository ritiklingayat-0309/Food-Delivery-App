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
                   
                   // Handle the like button action in the wishlist
                   cell.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                   cell.onLike = { [weak self] in
                       guard let self = self,
                             let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
                       
                       // Remove the item from the wishlist
                       appDelegate.arrWishlist.remove(at: indexPath.row)
//                       appDelegate.saveWishlist() // Save the updated wishlist
                       self.tblView.reloadData()
                       self.updateUI() // Update UI for empty state if needed
                   }
               } else { // Handle Cart view
                   cell.btnDelete.isHidden = false
                   cell.btnLike.isHidden = true // Hide the like button in cart view
                   cell.onDelete = { [weak self] in
                       guard let self = self,
                             let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
                       
                       appDelegate.arrCart.remove(at: indexPath.row)
                       appDelegate.saveCart()
                       self.updateUI() // Use the updatedUI function here
                   }
               }
        return cell
    }
}
