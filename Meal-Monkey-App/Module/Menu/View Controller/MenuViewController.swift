//
//  MenuViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Lottie
import UIKit

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
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        
        // Configure table view
        tblView.backgroundColor = .clear
        tblView.register(
            UINib(nibName: Main.CellIdentifier.MenuTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifier.MenuTableViewCell
        )
        
        // Apply custom styling to search textfield
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtSearch])
        
        // Set delegates
        tblView.delegate = self
        tblView.dataSource = self
        setupNoResultAnimation()
        
        // Observe language change
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageDidChange),
            name: .languageChanged,
            object: nil
        )
        
        applyTheme()
        
        // Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: Notification.Name("themeChanged"),
            object: nil
        )
        
        setupUI()
    }
    
    @objc func languageDidChange() {
        // Refresh all text in the UI
        setupUI()
        tblView.reloadData()
    }
    
    // Create a function to set UI elements
    func setupUI() {
        self.setLeftAlignedTitle(
            LocalizationManager.shared.localizedString(forKey: "menu_nav_title")
        )
        
        // If you have buttons, labels, placeholders, reload them too
        txtSearch.placeholder = LocalizationManager.shared.localizedString(
            forKey: "search_placeholder"
        )
        
        tblView.reloadData()
    }
    
    // MARK: - Setup Lottie
    private func setupNoResultAnimation() {
        // Animation
        noResultAnimationView = LottieAnimationView(name: "Search")  // your JSON name
        if let noResultAnimationView = noResultAnimationView {
            noResultAnimationView.translatesAutoresizingMaskIntoConstraints =
            false
            noResultAnimationView.contentMode = .scaleAspectFit
            noResultAnimationView.loopMode = .loop
            noResultAnimationView.isHidden = true
            view.addSubview(noResultAnimationView)
            
            // Constraints for animation
            NSLayoutConstraint.activate([
                noResultAnimationView.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
                noResultAnimationView.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor,
                    constant: -40
                ),
                noResultAnimationView.widthAnchor.constraint(
                    equalTo: view.widthAnchor,
                    multiplier: 0.7
                ),
                noResultAnimationView.heightAnchor.constraint(
                    equalToConstant: 250
                ),
            ])
        }
        
        // Label
        noResultLabel = UILabel()
        if let noResultLabel = noResultLabel {
            noResultLabel.text = LocalizationManager.shared.localizedString(
                forKey: "no_result_found"
            )
            
            noResultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            noResultLabel.textColor = .darkGray
            noResultLabel.textAlignment = .center
            noResultLabel.isHidden = true
            noResultLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(noResultLabel)
            
            // Constraints for label (below animation)
            NSLayoutConstraint.activate([
                noResultLabel.topAnchor.constraint(
                    equalTo: noResultAnimationView!.bottomAnchor,
                    constant: 16
                ),
                noResultLabel.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
            ])
        }
    }
    
    // MARK: - Navigation Actions
    
    /// Opens `CartViewController` when cart button is tapped.
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.MenuListStoryboard,
            bundle: nil
        )
        if let secondVC = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.CartViewController
        ) as? CartViewController {
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
    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme
        // Search bar styling
        txtSearch.backgroundColor = theme.cellBackgroundColor
        txtSearch.textColor = theme.primaryFontColor
        txtSearch.layer.cornerRadius = 28
        txtSearch.layer.borderWidth = 1
        txtSearch.clipsToBounds = true
        txtSearch.layer.borderColor = UIColor.black.cgColor
        if let placeholder = txtSearch.placeholder {
            txtSearch.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedString.Key.foregroundColor: theme
                        .placeholderColor
                ]
            )
        }
        
        // TableView background
        tblView.backgroundColor = .clear
        tblView.reloadData()  // so cells also get themed
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name("themeChanged"),
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: .languageChanged,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name("themeChanged"),
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: .languageChanged,
            object: nil
        )
    }
}
