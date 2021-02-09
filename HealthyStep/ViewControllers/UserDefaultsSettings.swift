//
//  UserDefaultsSettings.swift
//  HealthyStep
//
//  Created by Darya Gumus on 6.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import UIKit

//struct KeyDefaults {
//    static let keyName = "gujfGWPulI"
//    static let keyBirthDate = "e6C7RfgnHh"
//    static let keyGender = "Bxea38Zy8I"
//    static let keyHeight = "eebNQcLuW1"
//    static let keyWeight = "DzoEnHXu2W"
//}

class UserDefaultsSettings: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserDefaults()
        loadUserDefaults()
    }
    
    func setUserDefaults() {
//        let name = nameTF.text
//        let birthDate = birthDateTF.text
//        let gender = genderPicker.selectedSegmentIndex
//        let height = heightTF.text
//        let weight = weightTF.text
//
//        userDefaults.setValue(name, forKey: KeyDefaults.keyName)
//        userDefaults.setValue(birthDate, forKey: KeyDefaults.keyBirthDate)
//        userDefaults.set(gender, forKey: KeyDefaults.keyGender)
//        userDefaults.setValue(height, forKey: KeyDefaults.keyHeight)
//        userDefaults.setValue(weight, forKey: KeyDefaults.keyWeight)
    }
    
    func loadUserDefaults() {
//        if let name = userDefaults.object(forKey: KeyDefaults.keyName) {
//            nameTF.text = name as? String
//        }
//        if let birthDate = userDefaults.object(forKey: KeyDefaults.keyBirthDate) {
//            birthDateTF.text = birthDate as? String
//        }
//        if let gender = userDefaults.object(forKey: KeyDefaults.keyGender) {
//            genderPicker.selectedSegmentIndex = gender as! Int
//        }
//        if let height = userDefaults.object(forKey: KeyDefaults.keyHeight) {
//            heightTF.text = height as? String
//        }
//        if let weight = userDefaults.object(forKey: KeyDefaults.keyWeight) {
//            weightTF.text = weight as? String
//        }
    }
    
}
