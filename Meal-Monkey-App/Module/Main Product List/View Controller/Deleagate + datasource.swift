//
//  Deleagate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Main.CellIdentifier.HomeTableViewCell,
                for: indexPath
            ) as! HomeTableViewCell
        cell.delegate = self

        if let layout = cell.collectionViewHome.collectionViewLayout
            as? UICollectionViewFlowLayout
        {
            if indexPath.row == 0 || indexPath.row == 2 {
                layout.scrollDirection = .horizontal
            } else {
                layout.scrollDirection = .vertical
            }
            cell.collectionViewHome.collectionViewLayout.invalidateLayout()
        }

        let isSearching = !(txtSearch.text ?? "").isEmpty  // new addede

        switch indexPath.row {
        case 0:
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.categories = ProductCategory.allCases
            cell.btnViewAll.isHidden = true
            cell.lblCollectionViewTitle.isHidden = true
            cell.collectionViewHomeHeight.constant = 113

        case 1:
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = Main.Home.popular
            cell.lblCollectionViewTitle.text =
                isSearching ? Main.Home.searchResult : Main.Home.popular  // new
            cell.delegate = self
            if isSearching {
                cell.products = arrfilteredProductData.filter {
                    $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5
                }
            } else if selectedCategory == .All {
                cell.products = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5
                }
            } else {
                cell.products = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5
                        && $0.objProductCategory == selectedCategory
                }
            }
            cell.collectionViewHomeHeight.constant =
                cell.collectionViewHome.collectionViewLayout
                .collectionViewContentSize.height

        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text =
                isSearching ? Main.Home.searchResult : Main.Home.MostPopular
            cell.lblCollectionViewTitle.text = Main.Home.MostPopular
            cell.collectionViewHomeHeight.constant = 185
            cell.delegate = self
            if isSearching {
                cell.products = arrfilteredProductData.filter {
                    $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0
                }
            } else if selectedCategory == .All {
                cell.products = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0
                }
            } else {
                cell.products = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0
                        && $0.objProductCategory == selectedCategory
                }
            }

        case 3:
            cell.collectionType = .recentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = Main.Home.recentItems
            cell.products = arrrecentItems
            cell.collectionViewHomeHeight.constant =
                cell.collectionViewHome.collectionViewLayout
                .collectionViewContentSize.height
        default:
            break
        }
        cell.collectionViewHome.reloadData()
        DispatchQueue.main.async {
            cell.collectionViewHome.layoutIfNeeded()
            cell.updateCollectionHeight()
        }
        return cell
    }
}
