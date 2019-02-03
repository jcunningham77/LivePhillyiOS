//
//  LPViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/2/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit

class LPViewController: UIViewController, UITextFieldDelegate {
    
    var purpColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let purpColor = uiColorFromRGB(rgbValue: 0xAD00FD)
        
//        let purpColor: UIColor = uiColorFromRGB(rgbValue: 0xAD00FD)
        

        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        textField.attributedPlaceholder = nil
        return true
    }
    
    
    //TODO why does the below method invocation cause a crash?
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "emailTextField" {
            if textField.text == nil || textField.text == "" {
                textField.attributedPlaceholder =
                    NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: purpColor])
            }
            
        }
        
        if textField.restorationIdentifier == "passwordTextField" {
            if textField.text == nil || textField.text == "" {
                textField.attributedPlaceholder =
                    NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: purpColor])
            }
            
        }
    }
    
    
    
    func uiColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
