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
            // **Change:** Capture the edited or original image
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                self.imgView.image = editedImage
                self.selectedImage = editedImage // **Change:** Store the selected image in the property
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.imgView.image = originalImage
                self.selectedImage = originalImage // **Change:** Store the selected image in the property
            }
            
            // Dismiss the image picker after selection
            dismiss(animated: true)
        }
        
        // **Change:** Add this delegate method to handle image picker cancellation
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
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
