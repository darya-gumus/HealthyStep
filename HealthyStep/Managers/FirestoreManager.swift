//
//  FirestoreManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 12.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase
 
class FirestoreManager {
    
    var dataToSave = WorkoutData(date: Date(), timerData: "", stepsData: "", distanceData: "", kcalData: "")
    
    func saveWorkoutData () {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
        
            Firestore.firestore().collection("users").document(uid).collection("workoutData").document().setData(dataToSave.workoutDictionary) { (error) in
                
                if let error = error {
                    print("Got an error: \(error.localizedDescription)")
                } else {
                    print("WorkoutData has been saved!")
                }
            }
        }
    }
    
    func loadWorkoutData(successBlock: @escaping ([WorkoutData]) -> Void) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            
            Firestore.firestore().collection("users").document(uid).collection("workoutData").addSnapshotListener { (querySnapshot, error) in
        
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
        
                var workoutData = documents.map { (queryDocumentSnapshot) -> WorkoutData in
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
    
    func loadSteps(successBlock: @escaping ([Steps]) -> Void) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            
            Firestore.firestore().collection("users").document(uid).collection("workoutData").getDocuments() { (querySnapshot, error) in
        
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
        
                var steps = documents.map { (queryDocumentSnapshot) -> Steps in
                    let docData = queryDocumentSnapshot.data()
                
                    //from Timestamp into Date formate
                    let firebaseDate = docData["date"] as? Timestamp
                    let date = firebaseDate?.dateValue() ?? Date()
                
                    //formatting to String
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM"
                    let dateString = formatter.string(from: date)
                    //formatting to Double
                    let dateDbl = Double(dateString) ?? 0.0
                
                    let stepsData = docData["steps"] as? String ?? "0"
                    //formatting to Double
                    let stepsDataDbl = Double(stepsData) ?? 0.0
                
                    return Steps(date: dateDbl, stepsData: stepsDataDbl)
                }
                steps.sort(by: {$0.date < $1.date })
                successBlock(steps)
            }
        }
    }
}
//extension FirestoreManager: SettingsStorage {
//    var userName: String? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//    
//    var userBirthDate: String? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//    
//    var userGender: Int? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//    
//    var userHeight: String? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//    
//    var userWeight: String? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//    
//    
//}
