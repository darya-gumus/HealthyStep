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
    
    @IBOutlet weak var timerCountLabel: UILabel!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var distanceCountLabel: UILabel!
    @IBOutlet weak var kcalCountLabel: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var saveWorkoutButton: UIButton!
    
    let pedometer = CMPedometer()
    var shouldStartUpdating: Bool = false
    
    var timer = Timer()
    var timerCounting: Bool = false
    var count = 0
    
    var docRef: DocumentReference!
    
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
        startUpdating()
        
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        timerCountLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        count = 0
    }

    func onStop() {
        startStopButton.setTitle("Start", for: .normal)
        stopUpdating()
        
        timerCounting = false
        timer.invalidate()
        
    }
    
    @objc func timerCounter() {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerCountLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
       var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func startUpdating() {
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
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }
    
    @IBAction func saveWorkoutTapped(_ sender: Any) {
        
        let workoutDate = Date()
        let timerData = timerCountLabel.text
        let stepsData = stepsCountLabel.text
        let distanceData = distanceCountLabel.text
        let kcalData = kcalCountLabel.text
    
        let dataToSave: [String: Any] = [
            "date": workoutDate,
            "timer": timerData,
            "steps": stepsData,
            "distance": distanceData,
            "kcal": kcalData
        ]
        
        docRef = Firestore.firestore().collection("workoutData").addDocument(data: dataToSave) { (error) in
            if let error = error {
                print("Got an error: \(error.localizedDescription)")
            } else {
                print("WorkoutData has been saved!")
            }
        }
    }
}
