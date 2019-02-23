//
//  RegisterViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 1/29/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    

    @IBAction func register(_ sender: Any) {
        //TODO: Set up a new user on our Firebase database
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error as Any)
            } else {        
                print("Registration Successful, setting flag")
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: DefaultsKeys.authKey)
                self.performSegue(withIdentifier: "registerToTabBar", sender: self)
            }
        }
        
    }
}
