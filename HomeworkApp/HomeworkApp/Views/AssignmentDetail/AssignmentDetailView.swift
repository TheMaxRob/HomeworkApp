//
//  AssignmentDetailView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

struct AssignmentDetailView: View {
    
    let assignment: Assignment
    @Binding var isShowingAssignmentDetailView: Bool
    @Binding var isShowingEditAssignmentView: Bool
    @StateObject var viewModel = AssignmentDetailViewModel()
    
    var body: some View {
        
        // TODO: Complete button
        
        ZStack {
            NavigationStack {
                VStack(alignment: .leading, spacing: 10) {
                    Button {
                        isShowingAssignmentDetailView = false
                    } label: {
                        DismissButton()
                            .padding(.top, 20)
                    }
                    HStack {
                        Text("\(assignment.name)")
                            .padding(.bottom, 5)
                            .padding(.top, 10)
                            .font(.title)
                        Button(action: {
                            isShowingEditAssignmentView = true
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                        })
                    }
                    HStack {
                        Text("Class: ")
                        Text("\(assignment.Class.name)")
                            .foregroundStyle(assignment.Class.color.uiColor)
                    }
                    
                    Text("Due: \(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))")
                    HStack {
                        Text("Priority: ")
                        Text("\(assignment.convertPriority(assignment: assignment))")
                            .foregroundStyle(assignment.priority.color)
                    }
                    .padding(.bottom, 7)
                    Text("\(assignment.info)")
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            Assignment.completeAssignment(assignment: assignment)
                            isShowingAssignmentDetailView = false
                            print(AssignmentData.completedAssignments)
                        }, label: {
                            CompleteButton()
                                .padding(.bottom, 25)
                        })
                        Spacer()
                    }
                    .padding(.top, 15)
                }
                .padding(.leading, 20)
                .frame(width: 350, height: 350)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                .navigationTitle("Assignment Details")
                .overlay(Button(action: {
                    viewModel.isShowingConfirmHWDeletionView = true
                }, label: {
                    TrashButton()
                        .padding(.init(top: 15, leading: 0, bottom: 0, trailing: 20))
                }), alignment: .topTrailing)
                .blur(radius: viewModel.isShowingConfirmHWDeletionView ? 10 : 0)
                .blur(radius: isShowingEditAssignmentView ? 10 : 0)
                .disabled(viewModel.isShowingConfirmHWDeletionView || isShowingEditAssignmentView)
                
            }
            if viewModel.isShowingConfirmHWDeletionView {
                ConfirmHWDeletionView(assignment: assignment, isShowingConfirmHWDeletionView: $viewModel.isShowingConfirmHWDeletionView, isShowingAssignmentDetailView: $isShowingAssignmentDetailView)
            }
            if isShowingEditAssignmentView {
                EditAssignmentView(isShowingEditAssignmentView: $isShowingEditAssignmentView, isShowingAssignmentDetailView: $isShowingAssignmentDetailView, thisAssignment: assignment)
            }
        }
    }
}

#Preview {
    AssignmentDetailView(assignment: MyData.sampleAssignment, isShowingAssignmentDetailView: .constant(true), isShowingEditAssignmentView: .constant(false))
}
