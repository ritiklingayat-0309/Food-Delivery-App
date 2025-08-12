//
//  checkOut + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import Foundation
import UIKit

extension CheckOutViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(
                withIdentifier: "CashOnDeliveryTableViewCell",
                for: indexPath
            ) as! CashOnDeliveryTableViewCell
            
        case 1, 2, 3:
            let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "VisaTableViewCell",
                for: indexPath
            ) as! VisaTableViewCell
            let cardIndex = indexPath.row - 1
            if cardIndex < arrCards.count {
                cell.lblCardNo.text = arrCards[cardIndex]
            }
            return cell
            
        case 4:
            return tableView.dequeueReusableCell(
                withIdentifier: "GmailTableViewCell",
                for: indexPath
            ) as! GmailTableViewCell
        default:
            return UITableViewCell()
        }
    }
}

