//
//  SettingsViewController.swift
//  HealthyStep
//
//  Created by Darya Gumus on 22.12.20.
//  Copyright © 2020 Darya Gumus. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var birthDate: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBAction func letsStartPressed(_ sender: Any) {
        let mainPage = MainViewController(nibName: "MainViewController", bundle: nil)
        mainPage.modalPresentationStyle = .fullScreen
        self.present(mainPage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }

    func createToolbar() -> UIToolbar {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthDate.inputView = datePicker
        birthDate.inputAccessoryView = createToolbar()
    }
  
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd.mm.yyyy"
        
        self.birthDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func heightSliderDidSlide(_ sender: UISlider){
        let value: Int = Int(sender.value)
        heightLabel.text = "\(value)"
    }
    @IBAction func weightSliderDidSlide(_ sender: UISlider){
        let value = ((sender.value)*10).rounded()/10
        weightLabel.text = "\(value)"
    }
}
