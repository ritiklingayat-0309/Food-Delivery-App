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
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtSearch])
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}

