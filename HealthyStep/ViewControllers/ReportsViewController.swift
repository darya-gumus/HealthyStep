//
//  ReportsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 3.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

class ReportsViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var workoutData = [WorkoutData]()
    
//    var firestoreManager = LoadFirestoreManager()
//    var workoutData = LoadFirestoreManager().workoutData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.firestoreManager.loadWorkoutData()
//        self.tableView.reloadData()
        
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

            self.tableView.reloadData()
            }
        }

}
    
extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var workout = workoutData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.setWorkout(workout: workout)
        
        return cell
    }
    
}
  
