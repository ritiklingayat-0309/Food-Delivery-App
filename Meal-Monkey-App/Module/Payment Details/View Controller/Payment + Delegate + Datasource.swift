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
        return arrPayment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PaymentDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as! PaymentDetailsTableViewCell
        cell.lblCardNo.text = "xxxxx1111"
        return cell
    }
}
