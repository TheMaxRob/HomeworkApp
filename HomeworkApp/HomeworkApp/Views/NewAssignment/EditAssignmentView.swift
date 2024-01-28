//
//  EditAssignmentView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI

struct EditAssignmentView: View {
    
    @StateObject var viewModel = NewHWViewModel()
    @Binding var isShowingEditAssignmentView: Bool
    @Binding var isShowingAssignmentDetailView: Bool
    var thisAssignment: Assignment
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section("New Assignment") {
                    TextField("\(thisAssignment.name)", text: $viewModel.assignment.name)
                    
                    Picker("Class", selection: $viewModel.assignment.Class) {
                        ForEach(ClassesData.classes) { Class in
                            Text(Class.name).tag(Class)
                        }
                    }
                    
                    Picker("Priority", selection: $viewModel.assignment.priority) {
                        ForEach(Assignment.Priority.allCases, id: \.self) { priority in
                            Text("\(priority.rawValue)").tag(priority)
                        }
                    }
                    
                    
                    DatePicker("Due Date:", selection: $viewModel.assignment.dueDate, displayedComponents: .date)
                    Button(action: {
                        // Replace old assignment
                        let index = AssignmentData.assignments.firstIndex { element in
                            thisAssignment.name == element.name
                        }
                        AssignmentData.assignments[index ?? 0] = viewModel.assignment
                        isShowingEditAssignmentView = false
                        isShowingAssignmentDetailView = false
                    }, label: {
                        Text("Save Changes")
                    })
                }
            }
            .frame(width: 300, height: 300)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 40)
            .overlay(Button {
                isShowingEditAssignmentView = false
            } label: {
                DismissButton()
                    .padding(.top, 15)
                    .padding(.trailing, 15)
            }, alignment: .topTrailing)
        }
        
        
    }
}


#Preview {
    EditAssignmentView(isShowingEditAssignmentView: .constant(true), isShowingAssignmentDetailView: .constant(true), thisAssignment: MyData.sampleAssignment)
}
