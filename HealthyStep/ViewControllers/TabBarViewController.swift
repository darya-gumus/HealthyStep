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
        let chartBar = ChartBarViewController()
        
        reportsVC.tabBarItem = UITabBarItem(title: "Reports", image: UIImage(systemName: "book"), tag: 0)
        chartBar.tabBarItem = UITabBarItem(title: "Chart Bar", image: UIImage(systemName: "chart.bar"), tag: 1)
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "figure.walk"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        tabBarVC.viewControllers = [ mainVC, reportsVC, chartBar, settingsVC ]
        
        self.view.addSubview(tabBarVC.view)
    }
}
