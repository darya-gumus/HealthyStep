//
//  SettingsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

struct KeyDefaults {
    static let keyName = "gujfGWPulI"
    static let keyBirthDate = "e6C7RfgnHh"
    static let keyGender = "Bxea38Zy8I"
    static let keyHeight = "eebNQcLuW1"
    static let keyWeight = "DzoEnHXu2W"
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    
    
    let userDefaults = UserDefaults.standard
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        loadUserDefaults()
    }
    
    @IBAction func letsStartPressed(_ sender: Any) {
        
        setUserDefaults()
        
        let mainPage = TabBarViewController()
        mainPage.modalPresentationStyle = .fullScreen
        self.present(mainPage, animated: true, completion: nil)
    }
    
    func setUserDefaults() {
        let name = nameTF.text
        let birthDate = birthDateTF.text
        let gender = genderPicker.selectedSegmentIndex
        let height = heightTF.text
        let weight = weightTF.text
        
        userDefaults.setValue(name, forKey: KeyDefaults.keyName)
        userDefaults.setValue(birthDate, forKey: KeyDefaults.keyBirthDate)
        userDefaults.set(gender, forKey: KeyDefaults.keyGender)
        userDefaults.setValue(height, forKey: KeyDefaults.keyHeight)
        userDefaults.setValue(weight, forKey: KeyDefaults.keyWeight)
    }
    
    func loadUserDefaults() {
        if let name = userDefaults.object(forKey: KeyDefaults.keyName) {
            nameTF.text = name as? String
        }
        if let birthDate = userDefaults.object(forKey: KeyDefaults.keyBirthDate) {
            birthDateTF.text = birthDate as? String
        }
        if let gender = userDefaults.object(forKey: KeyDefaults.keyGender) {
            genderPicker.selectedSegmentIndex = gender as! Int
        }
        if let height = userDefaults.object(forKey: KeyDefaults.keyHeight) {
            heightTF.text = height as? String
        }
        if let weight = userDefaults.object(forKey: KeyDefaults.keyWeight) {
            weightTF.text = weight as? String
        }
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    @objc func doneButtonPressed() {
        let birthDate = datePicker.date
        let todayDate = Date()
        
        if birthDate < todayDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "dd.MM.yyyy"
        
            self.birthDateTF.text = dateFormatter.string(from: datePicker.date)
            self.view.endEditing(true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please, select correct date!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthDateTF.inputView = datePicker
        birthDateTF.inputAccessoryView = createToolbar()
    }
  
   
    
    @IBAction func signOutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.dismiss(animated: false, completion: nil)
                self.present(FirstPageViewController(), animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }

}
