//
//  Delegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Called when the user finishes picking an image from the image picker
    /// - Parameters:
    ///   - picker: The UIImagePickerController instance
    ///   - info: A dictionary containing the picked image and other metadata
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        // Set the selected/edited image to the profile image view
        imgView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        // Dismiss the image picker after selection
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
    /// Handles return key navigation between text fields
    /// - Parameter textField: The active UITextField
    /// - Returns: A boolean indicating whether the return action was handled
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case lblName:        // When Name field return is pressed → go to Email field
            lblEmail.becomeFirstResponder()
            
        case lblEmail:       // When Email field return is pressed → go to Mobile field
            lblMobile.becomeFirstResponder()
            
        case lblMobile:      // When Mobile field return is pressed → go to Address field
            lblAdress.becomeFirstResponder()
            
        case lblAdress:      // When Address field return is pressed → dismiss keyboard
            textField.resignFirstResponder()
            
        default:             // Default case → dismiss keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}
