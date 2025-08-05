//
//  MenuViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import UIKit

class MenuViewController: UIViewController {
    var arrMenu : [Menu] = Menu.addMenuList()
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLeftAlignedTitle("Menu")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        viewStyle(textfield: [txtSearch])
        setPadding(textfield: [txtSearch])
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
    }
    
    func viewStyle(textfield: [UIView]){
        for item in textfield {
            item.viewStyle(cornerRadius: 22.5, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}

