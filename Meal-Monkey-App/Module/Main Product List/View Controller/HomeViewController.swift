//
//  HomeViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Good morning Akila!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        tblView.showsVerticalScrollIndicator = false
        tblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tblView.reloadData()
    }
    @objc func btnCartTapped() {
    }
}
