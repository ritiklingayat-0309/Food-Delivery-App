//
//  Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation
import UIKit

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.configMenu(menu : arrMenu[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
}
