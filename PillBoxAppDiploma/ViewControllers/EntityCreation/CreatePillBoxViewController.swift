//
//  CreatePillBoxViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit
import RealmSwift

class CreatePillBoxViewController: UIViewController {
    
    
    var PillEntityArray: PillBoxEntityRealm?
    
    
    
    @IBOutlet var pillName: UITextField!
    @IBOutlet var pillCount: UITextField!
    @IBOutlet var pillDescription: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pillCount.keyboardType = .numberPad
        

        
    }
    
    
    
    
    @IBAction func donebuttonPressed() {
        
        guard let pName = pillName.text else { return }
        guard let pCount = pillCount.text else { return }
        guard let pDesc = pillDescription.text else { return }
        
        PillEntityArray?.pillName = pName
        PillEntityArray?.pillCount = Int(pCount) ?? 0
        PillEntityArray?.pillDescription = pDesc
        
        
        
      
        
        
        
    }
    
    
    
    
    
    
  

    
    

}
