//
//  MainViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase
import CoreMotion


class MainViewController: UIViewController {

    let pedometer = CMPedometer()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pedometer.startUpdates(from: Date()) { (data, error) in
            print(data)
        }
    }
    
    
    @IBAction func signOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
