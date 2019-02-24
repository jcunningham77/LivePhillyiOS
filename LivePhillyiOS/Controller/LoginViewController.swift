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

class LoginViewController: AuthViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        
        errorLabel.isHidden = true
        emailTextField.placeholder = "Email Address"
        emailTextField.title = "Email Address"
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    


    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if error != nil {
                print(error ?? "error")
                print(error as Any)
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    self.parseAuthErrorCode(errCode, error, self.errorLabel)
                    
                    
                    self.emailTextField.text = ""
                    
                    self.passwordTextField.text = ""
                    
                    self.emailTextField.becomeFirstResponder()
                }
                

                
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
