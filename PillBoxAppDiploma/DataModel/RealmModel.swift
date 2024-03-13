//
//  File.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 08.06.2023.
//

import Foundation
import RealmSwift



class ReminderEntityRealm: Object {
    @Persisted var name: String = ""
    @Persisted var date: Date = Date()
    @Persisted var pillEntity: PillBoxEntityRealm?
    
    
//    init(name: String, date: DateComponents, pillEntity: PillBoxEntity? = nil) {
//        var dateComponents = DateComponents()
//        dateComponents.hour = 00
//        dateComponents.minute = 00
//        self.name = name
//        self.date = dateComponents
//        self.pillEntity = pillEntity
//    }
    
//    override init() {
//        name = ""
//        var components = DateComponents()
//        components.hour = 00
//        components.minute = 00
//        date = components
//    }
//
    
}


class PillBoxEntityRealm: Object {
    @Persisted var pillName: String = ""
    @Persisted var pillCount: Int = 0
    @Persisted var pillDescription: String = ""
}
