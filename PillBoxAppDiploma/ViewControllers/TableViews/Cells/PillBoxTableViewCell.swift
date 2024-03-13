//
//  PillBoxTableViewCell.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 07.06.2023.
//

import UIKit

class PillBoxTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
