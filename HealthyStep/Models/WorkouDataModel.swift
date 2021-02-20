//
//  WorkouDataModel.swift
//  HealthyStep
//
//  Created by Darya Gumus on 14.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import Foundation

struct WorkoutData {
    var date: Date
    var timerData: String
    var stepsData: String
    var distanceData: String
    var kcalData: String
   
    var workoutDictionary: [String: Any] {
        return [
            "date": date,
            "timer": timerData,
            "steps": stepsData,
            "distance": distanceData,
            "kcal": kcalData
        ]
    }
}

