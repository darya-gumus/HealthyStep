//
//  FirstPageViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 21.01.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        let logInPage = LoginViewController(nibName: "LoginViewController", bundle: nil)
        logInPage.modalPresentationStyle = .fullScreen
        self.present(logInPage, animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let signUpPage = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        signUpPage.modalPresentationStyle = .fullScreen
        self.present(signUpPage, animated: true, completion: nil)
    }
}
