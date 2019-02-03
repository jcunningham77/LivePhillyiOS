//
//  LoginViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 1/29/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: LPViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let purpColor: UIColor = uiColorFromRGB(rgbValue: 0xAD00FD)
        
        emailTextField.attributedPlaceholder =
            NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: purpColor])
        passwordTextField.attributedPlaceholder =
            NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: purpColor])
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    


    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if error != nil {
                print(error ?? "error")
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
