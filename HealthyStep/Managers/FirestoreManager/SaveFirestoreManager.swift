//
//  FirestoreManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 12.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase
 
class SaveFirestoreManager {
    
    var dataToSave = WorkoutDataD(date: Date(), timerData: "", stepsData: "", distanceData: "", kcalData: "")

    func saveWorkoutData () {
        Firestore.firestore().collection("workoutData").addDocument(data: dataToSave.workoutDictionary) { (error) in
            if let error = error {
                print("Got an error: \(error.localizedDescription)")
            } else {
                print("WorkoutData has been saved!")
            }
        }
    }
    
}


