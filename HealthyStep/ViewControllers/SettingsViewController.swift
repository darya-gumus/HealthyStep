//
//  SettingsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

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
        
        userDefaults.setValue(nameTF.text, forKey: "name")
        userDefaults.setValue(birthDateTF.text, forKey: "birthDate")
        userDefaults.set(genderPicker.selectedSegmentIndex, forKey: "gender")
        userDefaults.setValue(heightTF.text, forKey: "height")
        userDefaults.setValue(weightTF.text, forKey: "weight")
        
        
        let mainPage = TabBarViewController()
        mainPage.modalPresentationStyle = .fullScreen
        self.present(mainPage, animated: true, completion: nil)
    }
    
    func loadUserDefaults() {
        if let name = userDefaults.object(forKey: "name") {
            nameTF.text = name as? String
        }
        if let birthDate = userDefaults.object(forKey: "birthDate") {
            birthDateTF.text = birthDate as? String
        }
        if let gender = userDefaults.object(forKey: "gender") {
            genderPicker.selectedSegmentIndex = gender as! Int
        }
        if let height = userDefaults.object(forKey: "height") {
            heightTF.text = height as? String
        }
        if let weight = userDefaults.object(forKey: "weight") {
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
