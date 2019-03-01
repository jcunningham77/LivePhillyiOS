//
//  AuthViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/24/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    
    @IBOutlet var bottomConstraintForKeyboard: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNotifications()
        let t = UITapGestureRecognizer(target: self, action: #selector(clearKeyboard))
        view.addGestureRecognizer(t)
        t.cancelsTouchesInView = false
        
        // Do any additional setup after loading the view.
    }
    
    func parseAuthErrorCode(_ errCode: AuthErrorCode, _ error: Error?, _ textLabel: UILabel) {
        switch errCode {
        case .emailAlreadyInUse:
            textLabel.text = "Sorry, this email is already in use. Please try another email, or login."
            textLabel.isHidden=false
            break
        case .weakPassword:
            textLabel.text = "Sorry, this password is too weak. Please try adding numbers and special characters."
            textLabel.isHidden=false
        default:
            textLabel.text = "Sorry, there was an error trying to register your account. Please try again."
            textLabel.isHidden=false
            print("Create User Error: \(error)")
        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let i = sender.userInfo!
        let k = (i[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        bottomConstraintForKeyboard.constant = k - bottomLayoutGuide.length
        let s: TimeInterval = (i[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let s: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        bottomConstraintForKeyboard.constant = 0
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }
    
    func keyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func clearKeyboard() {
        view.endEditing(true)
    }
}
