//
//  TabBarViewController1.swift
//  HealthyStep
//
//  Created by Darya Gumus on 4.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    
    let tabBarVC = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reportsVC = ReportsViewController()
        let mainVC = MainViewController()
        let settingsVC = SettingsViewController()
        
        reportsVC.tabBarItem = UITabBarItem(title: "Reports", image: UIImage(systemName: "book"), tag: 0)
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "star"), tag: 1)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        tabBarVC.viewControllers = [ mainVC, reportsVC, settingsVC]
        
        self.view.addSubview(tabBarVC.view)
    }
  
}
