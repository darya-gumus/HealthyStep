//
//  UserSettingsManager.swift
//  HealthyStep
//
//  Created by Darya Gumus on 6.02.21.
//  Copyright © 2021 Darya Gumus. All rights reserved.
//

import Foundation

struct KeyDefaults {
    static let keyName = "UserName.settings.key"
    static let keyBirthDate = "BirthDate.settings.key"
    static let keyGender = "Gender.settings.key"
    static let keyHeight = "Height.settings.key"
    static let keyWeight = "Weight.settings.key"
}

class UserSettingsManager {
    static let userDefaults = UserDefaults.standard
    
    public static var userNameSettings: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyName)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyName)
        }
    }
    public static var userBirthDateSettings: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyBirthDate)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyBirthDate)
        }
    }
    public static var userGenderSettings: Int? {
        get {
            userDefaults.integer(forKey: KeyDefaults.keyGender)
        }
        set {
            userDefaults.set(newValue, forKey: KeyDefaults.keyGender)
        }
    }
    public static var userHeightSettings: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyHeight)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyHeight)
        }
    }
    public static var userWeightSettings: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyWeight)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyWeight)
        }
    }
}
