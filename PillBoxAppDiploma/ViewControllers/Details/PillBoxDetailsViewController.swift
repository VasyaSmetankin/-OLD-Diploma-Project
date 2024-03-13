//
//  PillBoxDetailsViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 02.05.2023.
//

import UIKit
import RealmSwift
class PillBoxDetailsViewController: UIViewController {
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var countTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    
    var pillBoxDetailsEntity: PillBoxEntityRealm?
    var entityIndex: Int?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        


        
    }
    
    @IBAction func textFieldEditingBegin(_ sender: UITextField) {
        sender.borderStyle = .roundedRect
    }
    
    @IBAction func TextFieldEditingEnd(_ sender: UITextField) {
        sender.borderStyle = .none
    }
    
    
    
    
    // MARK: -  textField action
    func setupTextField() {
        guard let name = pillBoxDetailsEntity?.pillName else { return }
        nameTextField.text = name
        guard let count = pillBoxDetailsEntity?.pillCount else { return }
        countTextField.text = String(count)
        guard let desc = pillBoxDetailsEntity?.pillDescription else { return }
        descTextField.text = desc
        
    }
    
    @IBAction func doneButtonDidTapped() {
        guard let name = nameTextField.text else { return }
//        pillBoxDetailsEntity?.pillName = name
        guard let count = countTextField.text else { return }
//        pillBoxDetailsEntity?.pillCount = Int(count) ?? 0
        guard let desc = descTextField.text else { return }
//        pillBoxDetailsEntity?.pillDescription = desc
        do {
                let realm = try Realm()
                try realm.write {
                    pillBoxDetailsEntity?.pillName = name
                    pillBoxDetailsEntity?.pillCount = Int(count) ?? 0
                    pillBoxDetailsEntity?.pillDescription = desc
                }
            } catch {
                print("error \(error)")
            }

    }
        
      
    
    }

    
    
    
    

    

