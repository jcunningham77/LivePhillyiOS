//
//  LoginViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 1/29/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

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
    }
    

    @IBAction func loginPressed(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func uiColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
