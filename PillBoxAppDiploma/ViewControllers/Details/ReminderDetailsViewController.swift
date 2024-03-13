//
//  ReminderDetailsViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 02.05.2023.
//

import UIKit
import RealmSwift

class ReminderDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    var pillBoxArr: Results<PillBoxEntityRealm>?
    var ReminderEntityDetail: ReminderEntityRealm?
    var entityIndex: Int?
    let datePicker = UIDatePicker()
    
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupDatePicker()
        pickerViewSetup()
        let realm = try! Realm()
        
        pillBoxArr = realm.objects(PillBoxEntityRealm.self)
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        print(pillBoxArr ?? "")
//    }
    
    
    @IBAction func TextfieldEditingDidBegin(_ sender: UITextField) {
        sender.borderStyle = .roundedRect
    }
    @IBAction func TextFieldEditingDidBegin(_ sender: UITextField) {
        sender.borderStyle = .none
    }
    
    

    
    func setupTextField() {
        guard let entityName = ReminderEntityDetail?.name else { return }
        nameTextField.text = entityName

        guard let entityDate = ReminderEntityDetail?.date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let calendar = Calendar.current

        dateTextField.text =  dateFormatter.string(from: entityDate)
        datePicker.setDate(entityDate,animated: true)
        guard let entityDesc = ReminderEntityDetail?.pillEntity else { return }
        descTextField.text = entityDesc.pillName
    }
    
    @IBAction func doneButtonDidTapped() {
        guard let name = nameTextField.text else { return }
//        ReminderEntityDetail?.name = name
        do {
                let realm = try Realm()
                try realm.write {
                    ReminderEntityDetail?.name = name
                }
            } catch {
                print("error \(error)")
            }

    }
    
    // MARK: -  date picker setup
    
    
    func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en_GB")
        dateTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.items = [flexibleSpace, doneButton]
        dateTextField.inputAccessoryView = toolbar
        dateTextField.delegate = self
    }
    
    @objc func doneButtonTapped() {
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
        
        do {
                let realm = try Realm()
                try realm.write {
                    ReminderEntityDetail?.date = date
                }
            } catch {
                print("error \(error)")
            }
//        ReminderEntityDetail?.date = date
//        ReminderEntityDetail?.date.hour = components.hour
//        ReminderEntityDetail?.date.minute = components.minute
//        
        
        
    }
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateTextField.resignFirstResponder()
        return true
    }
    
    // MARK: -  picker view setup
    
    func pickerViewSetup() {
        let picker = UIPickerView()
        descTextField.inputView = picker
        picker.delegate = self
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toolBarDoneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        toolbar.setItems([doneButton], animated: false)
        descTextField.inputAccessoryView = toolbar
    }
    
    @objc func toolBarDoneButtonTapped() {
        descTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let PBArr = pillBoxArr else { return 0 }
        return PBArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let selectedEntity = pillBoxArr else { return nil }
        return selectedEntity[row].pillName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let PBArr = pillBoxArr else { return }
        let selectedEntity = PBArr[row]
        descTextField.text = selectedEntity.pillName
        
        do {
                let realm = try Realm()
                try realm.write {
                    ReminderEntityDetail?.pillEntity = selectedEntity
                }
            } catch {
                print("error \(error)")
            }
        
    }
    
    
    
 
    
    
    
    
    
    
    
    

   
}
