//
//  FetchFirestoreManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 14.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import Foundation
import FirebaseFirestore

class LoadFirestoreManager {
    
    var workoutData = [WorkoutData]()

    func loadWorkoutData() {
        Firestore.firestore().collection("workoutData").addSnapshotListener { (querySnapshot, error) in
        
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.workoutData = documents.map{ (queryDocumentSnapshot) -> WorkoutData in
                let docData = queryDocumentSnapshot.data()
            
                let date = docData["data"] as? Date ?? Date()
                let timerData = docData["timer"] as? String ?? "00 : 00 : 00"
                let stepsData = docData["steps"] as? String ?? "0"
                let distanceData = docData["distance"] as? String ?? "0.0"
                let kcalData = docData["kcal"] as? String ?? "0"
            
                return WorkoutData(date: date, timerData: timerData, stepsData: stepsData, distanceData: distanceData, kcalData: kcalData)
            }
//        print(self.workoutData)
        }
    }
}
