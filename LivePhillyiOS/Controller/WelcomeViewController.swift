//
//  WelcomeViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 1/29/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let screenSize: CGRect = UIScreen.main.bounds
        let xPosition = self.logoImage.frame.origin.x
        var yPosition = screenSize.height * 0.7
        let height = self.logoImage.frame.size.height
        let width = self.logoImage.frame.size.width
        self.logoImage.frame = CGRect(x: xPosition, y: yPosition, width:width, height: height)
        
        yPosition = screenSize.height * 0.3
        
        
        UIView.animate(withDuration: 1.2, delay: 0.1, options: [.curveEaseOut], animations: {
            self.logoImage.alpha = 1.0
            self.logoImage.frame = CGRect(x: xPosition, y: yPosition, width:width, height: height)
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
            self.navigate()
        })
    }
    
    func navigate() {
        let defaults = UserDefaults.standard
        let auth = defaults.bool(forKey: DefaultsKeys.authKey)
        if auth == true {
            print("WelcomeViewController: the user is already logged in")
            self.performSegue(withIdentifier: "welcomeToTabBar", sender: self)
        } else {
            self.performSegue(withIdentifier: "welcomeToLogin", sender: self)
        }
    }
}
