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
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    var shouldStartUpdating: Bool = false
    var startDate: Date? = nil
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startStopButton.addTarget(self, action: #selector(didTapStartStopButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapStartStopButton() {
           shouldStartUpdating = !shouldStartUpdating
           shouldStartUpdating ? (onStart()) : (onStop())
    }
    
    func onStart() {
        startStopButton.setTitle("Stop", for: .normal)
        stepsCountLabel.text = "0"
        startDate = Date()
        startUpdating()
    }

    func onStop() {
        startStopButton.setTitle("Start", for: .normal)
        startDate = nil
        stopUpdating()
    }
    
    func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async {
                    if let activiry = data {
                        if activiry.running == true {
                            self.activityLabel.text = "Running"
                        } else if activiry.walking == true {
                            self.activityLabel.text = "Walking"
                        } else if activiry.stationary == true {
                            self.activityLabel.text = "Stationary"
                        }
                    }
                }
            }
        } else {
            activityLabel.text = "Activity Manager Not available"
        }
           
        
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) { (pedometerData, error) in
                if error == nil {
                    if let data = pedometerData {
                        DispatchQueue.main.async { [weak self] in
                            self?.stepsCountLabel.text = "\(data.numberOfSteps)"
                        }
                    } else {
                        self.stepsCountLabel.text = "Steps are not avalible"
                    }
                }
            }
                
        } else {
            stepsCountLabel.text = "Step Counter Not available"
        }
    }


    func stopUpdating() {
            activityManager.stopActivityUpdates()
            pedometer.stopUpdates()
            pedometer.stopEventUpdates()
    }
    

    
    @IBAction func goToSettingsButton(_ sender: Any) {
        let settingsPage = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        settingsPage.modalPresentationStyle = .fullScreen
        self.present(settingsPage, animated: true, completion: nil)
    }
    
    
}
