//
//  TableViewCell.swift
//  HealthyStep
//
//  Created by Darya Gumus on 14.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    
    
    func setWorkout(workout: WorkoutData) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy  HH:mm"
        let dateString = formatter.string(from: workout.date)
        
        dateLabel.text = dateString
        timerLabel.text = workout.timerData
        stepsLabel.text = workout.stepsData + " steps"
        distanceLabel.text = workout.distanceData + " km"
        kcalLabel.text = workout.kcalData + " kcal"
    }
}

