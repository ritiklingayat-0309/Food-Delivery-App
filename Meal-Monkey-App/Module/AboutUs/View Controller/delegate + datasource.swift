//
//  delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation
import UIKit

extension AboutUsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell : AboutUsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        
        switch objPageType {
        case .About:
            cell.configaboutcell(about: currentData[indexPath.row])
            
        case .Notification:
            cell.configNotificationcell(about: currentData[indexPath.row])
            
        case .Inbox:
            cell.configInboxcell(about: currentData[indexPath.row])
            
        default:
            break
        }
        return cell
    }
}
