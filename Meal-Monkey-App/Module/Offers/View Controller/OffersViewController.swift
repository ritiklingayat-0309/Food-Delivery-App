//
//  OffersViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

/// View controller that displays a list of available offers to the user.
///
/// Responsibilities:
/// - Shows latest offers in a table view.
/// - Provides a button (`btnCheckOffer`) for checking offers.
/// - Includes a cart button in the navigation bar for quick cart access.
class OffersViewController: UIViewController {
    
    // MARK: - Properties
    /// Array of offers retrieved from the model.
    var arrOffer: [offer] = offer.getAllOffers()
    
    // MARK: - Outlets
    
    /// Button to check offers.
    @IBOutlet weak var btnCheckOffer: UIButton!
    
    /// Table view displaying the list of offers.
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide scroll indicators for a cleaner UI.
        tblView.showsVerticalScrollIndicator = false
        
        // Set navigation bar title (aligned to left).
        setLeftAlignedTitle("Latest Offers")
        
        // Add cart button to navigation bar.
        setCartButton(target: self, action: #selector(cartTapped))
        
        // Register custom table view cell.
        tblView.register(
            UINib(nibName: "OffersTableViewCell", bundle: nil),
            forCellReuseIdentifier: "OffersTableViewCell"
        )
        
        // Style: make the button circular by setting corner radius.
        btnCheckOffer.layer.cornerRadius = btnCheckOffer.frame.height / 2
    }
    
    // MARK: - Actions
    /// Triggered when the cart button is tapped in the navigation bar.
    @objc func cartTapped() {
        print("Cart tapped")
        
        // Navigate to CartViewController.
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    /// Action triggered when the "Check Offer" button is tapped.
    /// - Parameter sender: The button instance triggering the action.
    @IBAction func btnCheckOfferAction(_ sender: Any) {
        // TODO: Implement navigation or feature for checking offers.
    }
}
