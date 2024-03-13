//
//  PillBoxEntity.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 10.05.2023.
//

struct PillBoxEntity {
    var pillName: String
    var pillCount: Int
    var pillDescription: String
    
    
    
    static func getPillBoxEntity () -> [PillBoxEntity] {
        let entity: [PillBoxEntity] = []
        return entity
    }
    
    init() {
        self.pillName = ""
        self.pillCount = 0
        self.pillDescription = ""
    }
    
    init(pillName: String, pillCount: Int, pillDescription: String) {
        self.pillName = pillName
        self.pillCount = pillCount
        self.pillDescription = pillDescription
    }
}
