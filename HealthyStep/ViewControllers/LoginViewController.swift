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
        let mainPage = TabBarViewController()
        entrance { (success) in
            if success {
                mainPage.modalPresentationStyle = .fullScreen
                self.present(mainPage, animated: true, completion: nil)
            }
        }
    }
 
    @IBAction func forgotPassAction(_ sender: Any) {
        let forgotPassAlert = UIAlertController(title: "Password reset", message: "Please, enter your email", preferredStyle: .alert)
        forgotPassAlert.addTextField(configurationHandler: nil)
        forgotPassAlert.textFields![0].placeholder = "Your email"
        
        forgotPassAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            Auth.auth().sendPasswordReset(withEmail: forgotPassAlert.textFields![0].text!) { error in
                if let _ = error {
                    let alert = UIAlertController(title: "Error", message: "Please, enter correct email!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Success", message: "A password reset email has been sent!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }))
        present(forgotPassAlert, animated: true, completion: nil)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let signUpPage = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        signUpPage.modalPresentationStyle = .fullScreen
        self.present(signUpPage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func entrance(completionHandler: @escaping (Bool)-> Void) {
        let email = emailField.text!
        let password = passwordField.text!
    
        if (!email.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
              if let _ = result {
                    completionHandler(true)
              } else {
                    completionHandler(false)
              }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please, fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}
