//
//  CreateReminderViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit
import RealmSwift





class CreateReminderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let realm = try! Realm()
    var ReminderEntityArray: ReminderEntityRealm?
    var PillBoxEntityArray: Results<PillBoxEntityRealm>?
    let datePicker = UIDatePicker()
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var descTextField: UITextField!

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewSetup()
        setupDatePicker()
        

        

    }
    func alert() {
        let alert = UIAlertController(title: "warning", message: "enter fill the textfield", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func buttonDidTapped() {
        guard let nameTF = nameTextField.text else { return }
//        guard let dateTF = dateTextField.text else { return }
//        guard let descTF = descTextField.text else { return }
        ReminderEntityArray?.name = nameTF
        
        
    }
    
    
    
    // MARK: -  date picker setup
    
    func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.locale = Locale(identifier: "en_GB")
        
        dateTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.items = [flexibleSpace, doneButton]
        dateTextField.inputAccessoryView = toolbar
        dateTextField.delegate = self
    }
    
    @objc func doneButtonTapped(onDateChanged :@escaping () -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        dateTextField.resignFirstResponder()
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute], from: datePicker.date)
        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        guard let date = calendar.date(from: dateComponents) else { return }
        ReminderEntityArray?.date = date
    }
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateTextField.resignFirstResponder()
        return true
    }
    
    
    // MARK: -  picker view setup
    
    func pickerViewSetup() {
        //pickerView interactions
        let picker = UIPickerView()
        descTextField.inputView = picker
        picker.delegate = self
        
        // toolBar interactions
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toolBarDoneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        toolbar.setItems([doneButton], animated: false)
        descTextField.inputAccessoryView = toolbar
    }
    
    // actions
    @objc func toolBarDoneButtonTapped() {
        descTextField.resignFirstResponder()
    }
    
    // delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pillBoxEntityArr = PillBoxEntityArray else { return 0 }
        return pillBoxEntityArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let pillBoxEntityArr = PillBoxEntityArray else { return nil }
        return pillBoxEntityArr[row].pillName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let pillBoxEntityArr = PillBoxEntityArray else { return }
        let selectedEntity = pillBoxEntityArr[row]
        descTextField.text = selectedEntity.pillName
        ReminderEntityArray?.pillEntity = selectedEntity
    }
    
    
    
    
   
}
