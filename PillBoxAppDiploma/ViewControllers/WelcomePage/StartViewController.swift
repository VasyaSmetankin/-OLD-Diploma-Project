//
//  StartViewController.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 20.06.2023.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "AppIcon")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        
        imageView.backgroundColor = .white
    }
    


   
}
