//
//  MoreViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class MoreViewController: UIViewController {
    var arrMore : [More] = More.addData()
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "MoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTableViewCell")
        self.setLeftAlignedTitle("More")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}

