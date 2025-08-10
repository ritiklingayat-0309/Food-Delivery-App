//
//  Deleagate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        if let layout = cell.collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = (indexPath.row == 0 || indexPath.row == 2) ? .horizontal : .vertical
        }
        
        switch indexPath.row {
        case 0:
            cell.collectionType = .category
            cell.lblCollectionViewTitle.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.collectionViewHome.layoutIfNeeded()
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            
        case 1:
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Popular"
            
        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Most Popular"
            cell.collectionViewHomeHeight.constant = 185
            
        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Recent Items"
            
        default:
            break
        }
        cell.collectionViewHome.reloadData()
        return cell
    }
}
