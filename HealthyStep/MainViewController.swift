//
//  MainViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
