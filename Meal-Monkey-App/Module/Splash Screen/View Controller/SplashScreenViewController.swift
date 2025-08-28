//
//  SplashScreenViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import UIKit

/// `SplashScreenViewController`
/// This controller is responsible for displaying the splash screen when the app launches.
/// After a short delay, it checks the user's login status (stored in Keychain) and decides
/// whether to show the main tab bar (if logged in) or navigate to the login screen.
class SplashScreenViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Called when the view has appeared on screen.
    /// Adds a delay (splash duration) and then checks login status.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show splash screen for 3 seconds
        sleep(3)
        self.checkLoginStatus()
    }
    
    private func checkLoginStatus() {
            let isLoggedIn = UserDefaults.standard.string(forKey: "LoginStatus") == "true"
            
            if isLoggedIn {
                // If logged in → go to Home TabBar
                self.showMainTabBar()
            } else {
                // If not logged in → go to Login screen
                let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
                if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
            }
        }
    
    // MARK: - Navigation
    /// Loads the main tab bar from `HomeStoryboard`
    /// and sets it as the root view controller of the app's window.
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        
        // Instantiate TabBarViewController
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController {
            
            // Open with default tab selected (index 2 in this case)
            tabBarController.selectedIndex = 2
            
            // Replace rootViewController with TabBar
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
