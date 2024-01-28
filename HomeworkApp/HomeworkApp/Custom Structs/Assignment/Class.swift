//
//  Class.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct Class: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var professor: String
    var location: String
    var color: CodableColor
    
    
    init() {
        name = ""
        professor = ""
        location = ""
        color = CodableColor(.white)
    }
    
    init(name: String, professor: String, location: String, color: CodableColor) {
        self.name = name
        self.professor = professor
        self.location = location
        self.color = color
    }
    
    
    
    func deleteClass(Class: Class) {
        let index = ClassesData.classes.firstIndex { element in
            Class.name == element.name
        }
        ClassesData.classes.remove(at: index ?? 0)
    }
}

