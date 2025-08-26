//
//  MenuViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import UIKit

/// ViewController responsible for displaying the menu list.
/// Handles search, table view population, and navigation to cart.
class MenuViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Array of menu items (preloaded using `Menu.addMenuList()`)
    var arrMenu: [Menu] = Menu.addMenuList()
    
    /// Filtered menu list based on search text
    var filteredMenu: [Menu] = []
    
    // MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Copy original menu into filtered menu at start
        filteredMenu = arrMenu

        
        // Setup navigation bar
        self.setLeftAlignedTitle("Menu")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        
        // Configure table view
        tblView.backgroundColor = .clear
        tblView.register(
            UINib(nibName: "MenuTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MenuTableViewCell"
        )
        
        // Apply custom styling to search textfield
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtSearch])
        
        // Set delegates
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    // MARK: - Navigation Actions
    
    /// Opens `CartViewController` when cart button is tapped.
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
