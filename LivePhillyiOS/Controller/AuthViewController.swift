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

    override func viewDidLoad() {
        super.viewDidLoad()

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
}
