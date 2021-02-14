//
//  DateFormatter.swift
//  HealthyStep
//
//  Created by Darya Gumus on 14.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import Foundation

func dateFormatter() {
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
    let dateString = formatter.string(from: date)
    
}
