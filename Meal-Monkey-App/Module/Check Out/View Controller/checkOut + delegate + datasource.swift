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
        return sharedPaymentCards.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(
                withIdentifier: "CashOnDeliveryTableViewCell",
                for: indexPath
            ) as! CashOnDeliveryTableViewCell
            
        case 1..<1 + sharedPaymentCards.count:
            let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "VisaTableViewCell",
                for: indexPath
            ) as! VisaTableViewCell
            let cardIndex = indexPath.row - 1
            if cardIndex < sharedPaymentCards.count {
                let cardDetails = sharedPaymentCards[cardIndex]
                if let fullCardNumber = cardDetails["cardNo"] {
                    let lastFourDigits = String(fullCardNumber.suffix(4))
                    cell.lblCardNo.text = "**** **** **** \(lastFourDigits)"
                }
            }
            return cell
            
        case 1 + sharedPaymentCards.count:
            return tableView.dequeueReusableCell(
                withIdentifier: "GmailTableViewCell",
                for: indexPath
            ) as! GmailTableViewCell
        default:
            return UITableViewCell()
        }
    }
}

