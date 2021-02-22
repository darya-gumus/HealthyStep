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
    
    var settingsHandler: SettingsStorage = UserSettingsManager.shared
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        nameTF.text = settingsHandler.userName
        birthDateTF.text = settingsHandler.userBirthDate
        genderPicker.selectedSegmentIndex = settingsHandler.userGender!
        heightTF.text = settingsHandler.userHeight
        weightTF.text = settingsHandler.userWeight
    }
    
    @IBAction func letsStartPressed(_ sender: Any) {
        
        settingsHandler.userName = nameTF.text ?? ""
        settingsHandler.userBirthDate = birthDateTF.text ?? ""
        settingsHandler.userGender = genderPicker.selectedSegmentIndex
        settingsHandler.userHeight = heightTF.text ?? ""
        settingsHandler.userWeight = weightTF.text ?? ""

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
                
                let firstPage = FirstPageViewController(nibName: "FirstPageViewController", bundle: nil)
                firstPage.modalPresentationStyle = .fullScreen
                
                self.present(firstPage, animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
}
