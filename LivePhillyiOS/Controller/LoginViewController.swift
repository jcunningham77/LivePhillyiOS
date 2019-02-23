//
//  LoginViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 1/29/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var loginErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        
        loginErrorLabel.isHidden = true
        emailTextField.placeholder = "Email Address"
        emailTextField.title = "Email Address"
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    


    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if error != nil {
                print(error ?? "error")
                self.loginErrorLabel.isHidden = false
                
                
                self.emailTextField.text = ""
                
                self.passwordTextField.text = ""
                
                self.emailTextField.becomeFirstResponder()
                
            } else {
                print("login Successful, setting flag")
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: DefaultsKeys.authKey)
                self.performSegue(withIdentifier: "loginToTabBar", sender: self)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


}
