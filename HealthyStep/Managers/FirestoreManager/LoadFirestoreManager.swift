//
//  FetchFirestoreManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 14.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import Foundation
import Firebase

class LoadFirestoreManager {
    func loadWorkoutData(successBlock: @escaping ([WorkoutData]) -> Void) {
        Firestore.firestore().collection("workoutData").addSnapshotListener { (querySnapshot, error) in
        
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            var workoutData = documents.map{ (queryDocumentSnapshot) -> WorkoutData in
                let docData = queryDocumentSnapshot.data()
                
                let firebaseDate = docData["date"] as? Timestamp
                let date = firebaseDate?.dateValue() ?? Date()
                
                let timerData = docData["timer"] as? String ?? "00 : 00 : 00"
                let stepsData = docData["steps"] as? String ?? "0"
                let distanceData = docData["distance"] as? String ?? "0.0"
                let kcalData = docData["kcal"] as? String ?? "0"
            
                return WorkoutData(date: date, timerData: timerData, stepsData: stepsData, distanceData: distanceData, kcalData: kcalData)
            }
            workoutData.sort(by: {$0.date > $1.date })
            successBlock(workoutData)
        }
    }
}
