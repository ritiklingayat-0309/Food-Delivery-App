//
//  MenuViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import UIKit
import Lottie

/// ViewController responsible for displaying the menu list.
/// Handles search, table view population, and navigation to cart.
class MenuViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Array of menu items (preloaded using `Menu.addMenuList()`)
    var arrMenu: [Menu] = Menu.addMenuList()
    
    /// Filtered menu list based on search text
    var filteredMenu: [Menu] = []
    
    /// For Animation
    private var noResultAnimationView: LottieAnimationView?
    
    /// For Lable
    private var noResultLabel: UILabel?
    
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
        setupNoResultAnimation()
    }
    
    // MARK: - Setup Lottie
    private func setupNoResultAnimation() {
        // Animation
        noResultAnimationView = LottieAnimationView(name: "Search") // your JSON name
        if let noResultAnimationView = noResultAnimationView {
            noResultAnimationView.translatesAutoresizingMaskIntoConstraints = false
            noResultAnimationView.contentMode = .scaleAspectFit
            noResultAnimationView.loopMode = .loop
            noResultAnimationView.isHidden = true
            view.addSubview(noResultAnimationView)
            
            // Constraints for animation
            NSLayoutConstraint.activate([
                noResultAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noResultAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
                noResultAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                noResultAnimationView.heightAnchor.constraint(equalToConstant: 250)
            ])
        }
        
        // Label
        noResultLabel = UILabel()
        if let noResultLabel = noResultLabel {
            noResultLabel.text = "No Result Found"
            noResultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            noResultLabel.textColor = .darkGray
            noResultLabel.textAlignment = .center
            noResultLabel.isHidden = true
            noResultLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(noResultLabel)
            
            // Constraints for label (below animation)
            NSLayoutConstraint.activate([
                noResultLabel.topAnchor.constraint(equalTo: noResultAnimationView!.bottomAnchor, constant: 16),
                noResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
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
    
    func updateUIForSearchResult() {
        if filteredMenu.isEmpty {
            tblView.isHidden = true
            noResultAnimationView?.isHidden = false
            noResultAnimationView?.play()
            noResultLabel?.isHidden = false
        } else {
            tblView.isHidden = false
            noResultAnimationView?.stop()
            noResultAnimationView?.isHidden = true
            noResultLabel?.isHidden = true
        }
    }
}
