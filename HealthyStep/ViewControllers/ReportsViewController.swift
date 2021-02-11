//
//  ReportsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 3.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase


class ReportsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var loadedData : [String : [String: Any]] = [:]
    
    let tableView: UITableView = {
           let table = UITableView()
           table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           return table
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        loadDataFromFirestoreCloud()
    }
    
    func loadDataFromFirestoreCloud() {
        Firestore.firestore().collection("workoutData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.loadedData = [document.documentID : document.data()]
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return loadedData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ""
        return cell
    }

}

  
