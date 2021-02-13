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
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        nameTF.text = UserSettingsManager.userNameSettings
        birthDateTF.text = UserSettingsManager.userBirthDateSettings
        genderPicker.selectedSegmentIndex = UserSettingsManager.userGenderSettings!
        heightTF.text = UserSettingsManager.userHeightSettings
        weightTF.text = UserSettingsManager.userWeightSettings
    }
    
    @IBAction func letsStartPressed(_ sender: Any) {
        
        UserSettingsManager.userNameSettings = nameTF.text ?? ""
        UserSettingsManager.userBirthDateSettings = birthDateTF.text ?? ""
        UserSettingsManager.userGenderSettings = genderPicker.selectedSegmentIndex
        UserSettingsManager.userHeightSettings = heightTF.text ?? ""
        UserSettingsManager.userWeightSettings = weightTF.text ?? ""

        let mainPage = TabBarViewController()
        mainPage.modalPresentationStyle = .fullScreen
        self.present(mainPage, animated: true, completion: nil)
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
