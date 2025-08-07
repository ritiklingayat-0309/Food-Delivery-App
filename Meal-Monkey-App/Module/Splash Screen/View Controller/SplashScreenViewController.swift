//
//  SplashScreenViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // sleep(3)
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "LoginViewController") as? LoginViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
