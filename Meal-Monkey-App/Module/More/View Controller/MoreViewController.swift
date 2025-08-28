//
//  MoreViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/// View controller responsible for displaying the "More" section of the app.
/// This section usually contains additional options/settings (e.g., Profile, Orders, Help).
class MoreViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Data source array containing `More` objects to populate the table view.
    var arrMore: [More] = More.addData()
    
    // MARK: - IBOutlets
    
    /// Table view used to display the list of "More" options.
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the view is loaded into memory.
    /// Responsible for registering the table view cell and setting up navigation items.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom table view cell
        tblView.register(UINib(nibName: "MoreTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "MoreTableViewCell")
        
        // Set navigation title
        self.setLeftAlignedTitle("More")
        
        // Add cart button to navigation bar
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    // MARK: - Actions
    
    /// Handles tap action on the cart button in the navigation bar.
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        
        // Navigate to Cart screen
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            
            // Pass `.Cart` as the page type
            secondVC.pagetype = .Cart
            
            // Push the CartViewController onto the navigation stack
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
