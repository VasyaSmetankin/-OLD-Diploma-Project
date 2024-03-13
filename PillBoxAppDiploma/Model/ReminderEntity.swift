//
//  Model.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import Foundation

struct ReminderEntity {
    var name: String
    var date: DateComponents
    var description: PillBoxEntity
    
    
    init(name: String, date: DateComponents, description: PillBoxEntity) {
        self.name = name
        self.date = date
        self.description = description
    }
    init() {
        var components = DateComponents()
        self.name = ""
        components.hour = 00
        components.minute = 00
        date = components
        self.description = PillBoxEntity()
    }
    

}
