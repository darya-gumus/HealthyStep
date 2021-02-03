//
//  SettingsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit
import Firebase

enum GenderType: String {
    case male
    case female
}

class UserModel: NSObject, NSCoding {
    
    let name: String
    let birthDate: String
    let gender: GenderType
    let height: Int
    let weight: Double
    
    init(name: String, birthDate: String, gender: GenderType, height: Int, weight: Double) {
        self.name = name
        self.birthDate = birthDate
        self.gender = gender
        self.height = height
        self.weight = weight
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(birthDate, forKey: "birthDate")
        coder.encode(gender.rawValue, forKey: "gender")
        coder.encode(height, forKey: "height")
        coder.encode(weight, forKey: "weight")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        birthDate = coder.decodeObject(forKey: "birthDate") as? String ?? ""
        gender = coder.decodeObject(forKey: "gender") as? GenderType ?? GenderType.female
        height = coder.decodeObject(forKey: "height") as? Int ?? 0
        weight = coder.decodeObject(forKey: "weight") as? Double ?? 0.0
    }
    
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    
    let datePicker = UIDatePicker()
    
    @IBAction func letsStartPressed(_ sender: Any) {
        
        let name = nameTF.text!
        let birthDate = birthDateTF.text!
        let gender = genderPicker.selectedSegmentIndex
        let height = heightTF.text!
        let weight = weightTF.text!
        
//       let userObject = UserModel(name: name, birthDate: birthDate, gender: gender, height: height, weight: weight)
        
//        UserSettings.userModel = userObject
        
        let mainPage = MainViewController(nibName: "MainViewController", bundle: nil)
        mainPage.modalPresentationStyle = .fullScreen
        self.present(mainPage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
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
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }

}
