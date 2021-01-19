//
//  LoginViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 19.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func logInAction(_ sender: Any) {
        let mainPage = MainViewController(nibName: "MainViewController", bundle: nil)
        entrance { (success) in
            if success {
                self.present(mainPage, animated: true, completion: nil)
            }
        }
    }
 
    @IBAction func forgotPassAction(_ sender: Any) {
        
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        let signUpPage = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        self.present(signUpPage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Please, fill in all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func entrance(completionHandler: @escaping (Bool)-> Void) {
        let email = emailField.text!
        let password = passwordField.text!
    
        if (!email.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
              if let result = result {
                    completionHandler(true)
              } else {
                    completionHandler(false)
              }
            }
        } else {
            showAlert()
        }
    }
        
}

