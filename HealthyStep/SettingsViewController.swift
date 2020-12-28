//
//  SettingsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func letsStartPressed(_ sender: Any) {
        let mainPage = MainViewController(nibName: "MainViewController", bundle: nil)
        self.present(mainPage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
