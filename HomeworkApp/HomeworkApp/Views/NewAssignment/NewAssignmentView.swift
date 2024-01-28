//
//  NewHWView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

struct NewAssignmentView: View {
    
    @StateObject var viewModel = NewHWViewModel()
    @Binding var isShowingNewAssignmentView: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section("New Assignment") {
                    TextField("Name", text: $viewModel.assignment.name)
                    
                    Picker("Class", selection: $viewModel.assignment.Class) {
                        ForEach(ClassesData.classes) { aClass in
                            Text(aClass.name).tag(aClass)
                        }
                    }
                    
                    Picker("Priority", selection: $viewModel.assignment.priority) {
                        ForEach(Assignment.Priority.allCases, id: \.self) { priority in
                            Text("\(priority.rawValue)").tag(priority)
                        }
                    }
                    .onChange(of: viewModel.assignment.Class, { oldValue, newValue in
                        print("Selected Class:  \(newValue)")
                    })
                    
                    
                    DatePicker("Due Date:", selection: $viewModel.assignment.dueDate, displayedComponents: .date)
                    
                    
                    Button(action: {
                        // Create new assignment and add it to data
                        let newAssignment = Assignment(name: viewModel.assignment.name, 
                                                       Class: viewModel.assignment.Class,
                                                       dueDate: viewModel.assignment.dueDate,
                                                       priority: viewModel.assignment.priority,
                                                       info: viewModel.assignment.info)
                        
                        print(newAssignment)
                        Assignment.saveAssignment(assignment: newAssignment)
                        isShowingNewAssignmentView = false
                        print(AssignmentData.assignments)
                        
                    }, label: {
                        Text("Create Asignment")
                    })
                }
            }
            .frame(width: 300, height: 300)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 40)
            .overlay(Button {
                isShowingNewAssignmentView = false
            } label: {
                DismissButton()
                    .padding(.top, 15)
                    .padding(.trailing, 15)
            }, alignment: .topTrailing)
        }
        
        
    }
}

#Preview {
    NewAssignmentView(isShowingNewAssignmentView: .constant(true))
}
