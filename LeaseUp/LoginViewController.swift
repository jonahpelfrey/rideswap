//
//  LoginViewController.swift
//  LeaseUp
//
//  Created by Jonah Pelfrey on 9/22/17.
//  Copyright © 2017 Jonah Pelfrey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        //Load background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        backgroundImage.image = UIImage(named: "loginS.png")

        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        emailField.center.x -= view.bounds.width
        passwordField.center.x -= view.bounds.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        if (UserDefaults.standard.object(forKey: "User.Registered") as? Bool) != nil {
            
            //User exists? 
            return
            
        } else {
            
            let email = emailField?.text
            let password = passwordField?.text
            let registered = true
            
            UserDefaults.standard.set(email, forKey: "User.Email")
            UserDefaults.standard.set(password, forKey: "User.Password")
            UserDefaults.standard.set(registered, forKey: "User.Registered")
            
        }
        
        //perform segue
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let email = UserDefaults.standard.object(forKey: "User.Email") as? String {
            
            emailField.text = email
            signUpButton.setTitle("Log In", for: .normal)
            
        }
        
        if let password = UserDefaults.standard.object(forKey: "User.Password") as? String {
            
            passwordField.text = password
        }
        
        UIView.animate(withDuration: 0.75) {
            self.emailField.center.x += self.view.bounds.width
            self.passwordField.center.x += self.view.bounds.width
        }
    }
    
}
