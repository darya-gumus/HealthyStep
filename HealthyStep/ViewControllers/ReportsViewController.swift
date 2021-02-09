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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.tableView.reloadData()
    }
}

    extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = ""
            return cell
        }
    }

