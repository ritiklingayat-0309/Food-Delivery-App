//
//  delgate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import Foundation
import UIKit

extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        let obj = arrMore[indexPath.row]
        cell.configMoreData(more : obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrMore[indexPath.row]
        switch selectedItem.intsTag{
        case 0:
            let storyboard = UIStoryboard(name:"MoreStoryboard", bundle : nil)
            if let secondVc = storyboard.instantiateViewController(withIdentifier : "PaymentDetailsViewController") as? PaymentDetailsViewController{
                self.navigationController?.pushViewController(secondVc, animated: true)
            }
            print("First row selected")
            
        case 1:
            let storyboard = UIStoryboard(name:"MenuListStoryboard", bundle : nil)
            if let secondVc = storyboard.instantiateViewController(withIdentifier : "OrderListViewController") as? OrderListViewController{
                self.navigationController?.pushViewController(secondVc, animated: true)
            }
            print("Second row selected")
            
        case 2:
            print("Third row selected")
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPageType = .Notification
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            
        case 3:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPageType = .Inbox
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("fourth row selected")
            
        case 4:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPageType = .About
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("fifth row selected")
            
        case 5 :
            let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
            if let secondVc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
                secondVc.pagetype = .Wishlist
                self.navigationController?.pushViewController(secondVc, animated: true)
            }
            
        default:
            print("Other row selected")
        }
    }
}

enum PageType {
    case PaymentDetails
    case MyOrder
    case Notification
    case Inbox
    case About
    case Wishlist
    case Cart
}


