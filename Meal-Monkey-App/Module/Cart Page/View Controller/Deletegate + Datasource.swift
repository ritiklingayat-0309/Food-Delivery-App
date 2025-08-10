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
        return  cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        let product = cartItems[indexPath.row]
        cell.configure(with: product)
        cell.onDelete = { [weak self] in
            guard let self = self,
                  let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
            appDelegate.arrCart.remove(at: indexPath.row)
            self.tblView.reloadData()
        }
        return cell
    }
}
