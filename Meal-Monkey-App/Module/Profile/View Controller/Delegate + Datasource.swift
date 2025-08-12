//
//  Delegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case lblName:
            lblEmail.becomeFirstResponder()
        case lblEmail:
            lblMobile.becomeFirstResponder()
        case lblMobile:
            lblAdress.becomeFirstResponder()
        case lblAdress:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
