//
//  MotionManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 12.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import Foundation
import CoreMotion

class MotionManager {
    let pedometer = CMPedometer()
    
    func startUpdating(motionDataHandler : @escaping (CMPedometerData?) -> Void) {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { (pedometerData, error) in
                if error == nil {
                    motionDataHandler(pedometerData)
                }
            }
        }
    }
}
