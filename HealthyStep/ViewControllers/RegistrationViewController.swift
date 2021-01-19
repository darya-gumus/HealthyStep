//
//  RegistrationViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 19.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    @IBAction func singUpAction(_ sender: Any) {
        let settingsPage = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        register { (success) in
            if success {
                self.present(settingsPage, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func logInAction(_ sender: Any) {
        let logInPage = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.present(logInPage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Please, fill in all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func register(completionHandler: @escaping (Bool)-> Void) {
        let email = emailField.text!
        let password = passwordField.text!
        let repeatPassword = repeatPasswordField.text!
                
        if (!email.isEmpty && !password.isEmpty && !repeatPassword.isEmpty && password == repeatPassword) {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
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

