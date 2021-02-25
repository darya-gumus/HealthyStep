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

protocol SettingsStorage {
    var userName: String? { get set }
    var userBirthDate: String? { get set }
    var userGender: Int? { get set }
    var userHeight: String? { get set }
    var userWeight: String? { get set }
}

class UserSettingsManager: SettingsStorage {
    
    private init() {}
    static let shared = UserSettingsManager()
    
    let userDefaults = UserDefaults.standard
    
    var userName: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyName)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyName)
        }
    }
    var userBirthDate: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyBirthDate)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyBirthDate)
        }
    }
    var userGender: Int? {
        get {
            userDefaults.integer(forKey: KeyDefaults.keyGender)
        }
        set {
            userDefaults.set(newValue, forKey: KeyDefaults.keyGender)
        }
    }
    var userHeight: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyHeight)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyHeight)
        }
    }
    var userWeight: String? {
        get {
            userDefaults.string(forKey: KeyDefaults.keyWeight)
        }
        set {
            userDefaults.setValue(newValue, forKey: KeyDefaults.keyWeight)
        }
    }
}
