//
//  DessertsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class DessertsViewController: UIViewController {
   
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    var selectedProductType: ProductType = .Desserts
    
    var arrProducts: [ProductModel] {
            return ProductModel.addProductData().filter { $0.objProductType == selectedProductType }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(
                "Food",
                target: self,
                action: #selector(backButtonTapped)
            )
        case .Beverages:
            setLeftAlignedTitleWithBack(
                "Beverages",
                target: self,
                action: #selector(backButtonTapped)
            )
        case .Desserts:
            setLeftAlignedTitleWithBack(
                "Desserts",
                target: self,
                action: #selector(backButtonTapped)
            )
        }
        tblView.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
        viewStyle(textfield: [txtSearch])
        setPadding(textfield: [ txtSearch])
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cartTapped() {
        print("Cart tapped")
    }
    
    func viewStyle(textfield: [UIView]){
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}



