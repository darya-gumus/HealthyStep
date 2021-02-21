//
//  ChartBarViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 19.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit
import Charts

class ChartBarViewController: UIViewController, ChartViewDelegate {

    var steps = [Steps]()
    
    var barChart = BarChartView()
    var entries = [BarChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center
        
        view.addSubview(barChart)
        
        LoadFirestoreManager().loadSteps { [weak self] steps in
            self?.steps = steps
            print(steps)
            
            for x in steps {
                self?.entries.append(BarChartDataEntry(x: Double(x.date) , y: Double(x.stepsData)))
            }
            
            let set = BarChartDataSet(entries: self?.entries)
            set.colors = ChartColorTemplates.liberty()
            let data = BarChartData(dataSet: set)
            self?.barChart.data = data
        }
    }
}
