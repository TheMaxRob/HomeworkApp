//
//  Assignment.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct Assignment: Identifiable, Codable {
    var id = UUID()
    var name: String
    var Class: Class
    var dueDate: Date
    var priority: Priority
    var info: String
    
    
    static func completeAssignment(assignment: Assignment) {
        print("Completing Assignment!")
        AssignmentData.completedAssignments.append(assignment)
        Assignment.deleteAssignment(assignment: assignment)
    }
    
    
    static func saveAssignment(assignment: Assignment) {
        AssignmentData.assignments.append(assignment)
    }
    
    
    static func deleteAssignment(assignment: Assignment) {
        let index = AssignmentData.assignments.firstIndex { element in
            assignment.name == element.name
        }
        AssignmentData.assignments.remove(at: index!)
    }
    
    func formatDateDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }

    func formatDateMonth(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        
        let monthString = dateFormatter.string(from: date)
        
        if monthString == "1" { return "Jan" }
        if monthString == "2" { return "Feb" }
        if monthString == "3" { return "Mar" }
        if monthString == "4" { return "Apr" }
        if monthString == "5" { return "May" }
        if monthString == "6" { return "June" }
        if monthString == "7" { return "July" }
        if monthString == "8" { return "Aug" }
        if monthString == "9" { return "Sep" }
        if monthString == "10" { return "Oct" }
        if monthString == "11" { return "Nov" }
        if monthString == "12" { return "Dec" }
        
        return dateFormatter.string(from: date)
    }
    
    func convertPriority(assignment: Assignment) -> String {
        if assignment.priority.color.description == "red" { return "High" }
        else if assignment.priority.color.description == "orange" { return "Mid" }
        else if assignment.priority.color.description == "green" { return "Low" }
        else { return "" }
        
    }
    
    enum Priority: String, CaseIterable, Codable {
        case low
        case mid
        case high
        
        var color: Color {
                switch self {
                case .low:  return Color.green
                case .mid:  return Color.yellow
                case .high: return Color.red
                }
            }
    }
    
    
}
