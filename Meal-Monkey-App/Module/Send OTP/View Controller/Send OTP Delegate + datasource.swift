//
//  Send OTP Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit
import DPOTPView

/// Extension of `SendOTPViewController` to handle OTP text field behavior.
/// Implements `UITextFieldDelegate` to:
/// - Restrict input to digits only.
/// - Allow only one character per text field.
/// - Automatically move to the next/previous field when typing or deleting.
extension SendOTPViewController: DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
            print("addText:- " + text + " at:- \(position)" )
        }
        
        func dpOTPViewRemoveText(_ text: String, at position: Int) {
            print("removeText:- " + text + " at:- \(position)" )
        }
        
        func dpOTPViewChangePositionAt(_ position: Int) {
            print("at:-\(position)")
        }
        func dpOTPViewBecomeFirstResponder() {
            
        }
        func dpOTPViewResignFirstResponder() {
            
        }
 
       
}
