//
//  ProfileViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblTitleUser: UILabel!
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblMobile: UITextField!
    @IBOutlet weak var lblAdress: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EditStyle.setPadding(textFields: [lblName,lblEmail,lblMobile,lblAdress], paddingWidth: 28)
        EditStyle.setborder(textfields: [lblName,lblEmail,lblMobile,lblAdress,btnSave])
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(imgeTab))
        imgView.addGestureRecognizer(tabGesture)
        imgView.layer.cornerRadius = imgView.frame.height/2
        self.setLeftAlignedTitle("Profile")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        
        btnSave.isHidden = true
        disableEditing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Fetch and display user data every time the view appears
            loadUserData()
        }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    @objc func imgeTab() {
        print("click on image")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    func loadUserData() {
            guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
                  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            let predicate = NSPredicate(format: "userID == %@", savedUserIDString)
            fetchRequest.predicate = predicate
            
            do {
                let users = try managedContext.fetch(fetchRequest)
                if let user = users.first {
                    lblName.text = user.value(forKey: "name") as? String
                    lblEmail.text = user.value(forKey: "email") as? String
                    lblMobile.text = user.value(forKey: "mobileNo") as? String
                    lblAdress.text = user.value(forKey: "address") as? String
                    lblTitleUser.text = "Hello, \(lblName.text ?? "User")!"
                 
                }
            } catch {
                print("Failed to fetch user data: \(error.localizedDescription)")
            }
        }
    
    @IBAction func btnEditProfileAction(_ sender: Any) {
        enableEditing()
    }
    private func enableEditing() {
          lblName.isEnabled = true
          lblEmail.isEnabled = true
          lblMobile.isEnabled = true
          lblAdress.isEnabled = true
          btnSave.isHidden = false
          btnEditProfile.isHidden = true
      }
      
      private func disableEditing() {
          lblName.isEnabled = false
          lblEmail.isEnabled = false
          lblMobile.isEnabled = false
          lblAdress.isEnabled = false
          btnSave.isHidden = true
          btnEditProfile.isHidden = false
      }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "loggedInUserID")
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        // 1. Get Core Data context and saved User ID
            guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
                  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // 2. Prepare the fetch request
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            let predicate = NSPredicate(format: "userID == %@", savedUserIDString)
            fetchRequest.predicate = predicate
            
            // 3. Perform the fetch and save within a single do-catch block
            do {
                let users = try managedContext.fetch(fetchRequest)
                
                if let userToUpdate = users.first {
                    // Update the user's attributes
                    userToUpdate.setValue(lblName.text, forKey: "name")
                    userToUpdate.setValue(lblEmail.text, forKey: "email")
                    userToUpdate.setValue(lblMobile.text, forKey: "mobileNo")
                    userToUpdate.setValue(lblAdress.text, forKey: "address")
                    
                   
                    
                    // Save the context
                    try managedContext.save()
                    
                    // Show success alert and disable editing
                    UIAlertController.showAlert(title: "Success", message: "Profile updated successfully!", viewController: self)
                    disableEditing()
                }
            } catch {
                // Handle any errors that occur during fetch or save
                print("Failed to save updated user data: \(error.localizedDescription)")
                UIAlertController.showAlert(title: "Error", message: "Failed to update profile.", viewController: self)
            }
         
                  
    }
        

    }

