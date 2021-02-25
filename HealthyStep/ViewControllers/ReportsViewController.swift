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
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirestoreManager().loadWorkoutData { [weak self] workouts in
            self?.workoutData = workouts
            self?.tableView.reloadData()
        }
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let workout = workoutData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.setWorkout(workout: workout)
        
        return cell
    }
}
  
