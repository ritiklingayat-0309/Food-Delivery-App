//
//  Payment + Delegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit
extension PaymentDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedPaymentCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PaymentDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as! PaymentDetailsTableViewCell
        cell.delegate = self
        let cardDetails = sharedPaymentCards[indexPath.row]
        if let cardNumber = cardDetails["cardNo"] {
            cell.configure(with : cardNumber)
        }
        return cell
    }
}
