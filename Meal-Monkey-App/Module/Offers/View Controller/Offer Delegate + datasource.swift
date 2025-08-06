//
//  Offer Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

extension OffersViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OffersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
        
        cell.configOffer(offer: arrOffer[indexPath.row])
        return cell
    }
}
