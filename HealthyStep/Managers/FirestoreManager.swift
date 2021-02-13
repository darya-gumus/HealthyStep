//
//  FirestoreManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 12.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

struct WorkoutData {
    
    var date: Date
    var timerData: String
    var stepsData: String
    var distanceData: String
    var kcalData: String
   
    var dictionary: [String: Any] {
        return [
            "date": date,
            "timer": timerData,
            "steps": stepsData,
            "distance": distanceData,
            "kcal": kcalData
        ]
    }
    
}
 
class FirestoreManager {
    
    var docRef: DocumentReference!
    var db = Firestore.firestore()

    var dataToSave = WorkoutData(date: Date(), timerData: "", stepsData: "", distanceData: "", kcalData: "")
    var loadedData: [[ String : [String : Any] ]] = [[:]]

    func saveWorkoutData () {
        docRef = db.collection("workoutData").addDocument(data: dataToSave.dictionary) { (error) in
            if let error = error {
                print("Got an error: \(error.localizedDescription)")
            } else {
                print("WorkoutData has been saved!")
            }
        }
    }

    func loadWorkoutData() {
        db.collection("workoutData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let docSnapshot = querySnapshot else { return }
                for document in docSnapshot.documents {
                    let doc = [document.documentID : document.data()]
                    self.loadedData += [doc]
                }
//                guard let docSnapshot = querySnapshot else { return }
//                let data = docSnapshot.documents.map { (snapshot) -> [String: Any] in
//                    return snapshot.data()
//                }
            }
                self.loadedData.remove(at: 0)
                print(self.loadedData)
            }
        }
    }


