//
//  DataStore.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/23/24.
//

import SwiftUI

class AssignmentStore: Observable, ObservableObject {
    
    @Published var assignments: [Assignment] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
        .appendingPathComponent("assignments.data")
    }
    
    
    func load() async throws {
            let task = Task<[Assignment], Error> {
                let fileURL = try Self.fileURL()
                guard let data = try? Data(contentsOf: fileURL) else {
                    return []
                }
                let assignments = try JSONDecoder().decode([Assignment].self, from: data)
                return assignments
            }
            let assignments = try await task.value
        
        DispatchQueue.main.async {
            AssignmentData.assignments = assignments
        }
    }
    
    
    func save(assignments: [Assignment]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(assignments)
            let outfile = try Self.fileURL()
                        try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
   
}


class  ClassStore: Observable, ObservableObject {
    @Published var classes: [Class] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
        .appendingPathComponent("classes.data")
    }
    
    
    func load() async throws {
            let task = Task<[Class], Error> {
                let fileURL = try Self.fileURL()
                guard let data = try? Data(contentsOf: fileURL) else {
                    return []
                }
                let classes = try JSONDecoder().decode([Class].self, from: data)
                return classes
            }
            let classes = try await task.value
        
        DispatchQueue.main.async {
            ClassesData.classes = classes
        }
    }
    
    
    func save(classes: [Class]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(classes)
            let outfile = try Self.fileURL()
                        try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
