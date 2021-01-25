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

    @IBOutlet weak var stepsLabel: UILabel!
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async {
                    if let activiry = data {
                        if activiry.running == true {
                            print("Running")
                        } else if activiry.walking == true {
                            print("Walking")
                        } else if activiry.stationary == true {
                            print("Stationary")
                        }
                    }
                }
            }
        }
    
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) { (pedometerData, error) in
                if error == nil {
                    if let data = pedometerData {
                        DispatchQueue.main.async {
                            print("Number of Steps - \(data.numberOfSteps)")
                            self.stepsLabel.text = "Steps - \(data.numberOfSteps)"
                        }
                    } else {
                        print("Steps are not avalible")
                        self.stepsLabel.text = "Steps are not avalible"
                    }
                }
            }
        }
        
    }
   
    
    @IBAction func signOutAction(_ sender: Any) {
    let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

