//
//  MyOrderViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

class MyOrderViewController: UIViewController {

    @IBOutlet weak var btnAddNote: UIButton!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitleWithBack("My Order", target: self, action: #selector(backButtonTapped))
        tblView.register(UINib(nibName: "MyOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrderTableViewCell")
        EditStyle.setborder(textfields: [btnCheckout])
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddNoteAction(_ sender: Any) {
    }
    
    @IBAction func btnCheckoutAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"MoreStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "CheckOutViewController") as? CheckOutViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
