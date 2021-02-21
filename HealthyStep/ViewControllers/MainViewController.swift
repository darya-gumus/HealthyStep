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
    
    let firestoreManager = SaveFirestoreManager()
    
    let motionManager = MotionManager()
    var shouldStartUpdating: Bool = false
    
    var timer = Timer()
    var timerCounting: Bool = false
    var count = 0
    
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
        distanceCountLabel.text = "0"
        kcalCountLabel.text = "0"
        
        motionManager.startUpdating { (pedometerData) in
            DispatchQueue.main.async { [weak self] in
                if let data = pedometerData {
                    
                    let steps = Int(truncating: data.numberOfSteps)
                    let distanceM = Int(truncating: data.distance!)

                    let weightKg = Double(UserSettingsManager.userWeightSettings ?? "60") ?? 60
                    
                    let kcal = 0.5 * weightKg * Double(distanceM / 1000)
                    let kcalStr = String(format:"%.1f", kcal)
                    
                    self?.stepsCountLabel.text = "\(steps)"
                    self?.distanceCountLabel.text = "\(distanceM)"
                    self?.kcalCountLabel.text = "\(kcalStr)"
                } else {
                    self?.stepsCountLabel.text = "Steps are not avalible"
                    print("Steps are not avalible")
                }
            }
        }
        
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        timerCountLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        count = 0
    }

    func onStop() {
        startStopButton.setTitle("Start", for: .normal)
        
        motionManager.pedometer.stopUpdates()
        motionManager.pedometer.stopEventUpdates()
        
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
    
    @IBAction func saveWorkoutTapped(_ sender: Any) {
        let workoutDate = Date()
        let timerData = timerCountLabel.text!
        let stepsData = stepsCountLabel.text!
        let distanceData = distanceCountLabel.text!
        let kcalData = kcalCountLabel.text!
        
        firestoreManager.dataToSave = WorkoutData(date: workoutDate, timerData: timerData, stepsData: stepsData, distanceData: distanceData, kcalData: kcalData)
        
        firestoreManager.saveWorkoutData()
    }
}
