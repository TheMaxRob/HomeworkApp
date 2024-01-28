//
//  ContentView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject var viewModel = HomePageViewModel()
    @EnvironmentObject var assignmentStore: AssignmentStore
    @EnvironmentObject var classStore: ClassStore
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    HStack(spacing: 0) {
                        
                        // Assignment List
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(AssignmentData.assignments) { assignment in
                                    AssignmentListItem(assignment: assignment, assignmentWasCompleted: $viewModel.assignmentWasCompleted)
                                        .listRowBackground(assignment.Class.color.uiColor.opacity(0.5))
                                        .onTapGesture {
                                            viewModel.selectedAssignment = assignment
                                            viewModel.isShowingAssignmentDetailView = true
                                        }
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Class Buttons
                        VStack(spacing: 20) {
                            ForEach(ClassesData.classes) { Class in
                                ClassSideButton(Class: Class)
                                    .onTapGesture {
                                        viewModel.selectedClass = Class
                                        viewModel.isShowingClassDetailView = true
                                    }
                            }
                            Button(action: {
                                viewModel.isShowingNewClassView = true
                            }, label: {
                                AddClassButton()
                            })
                        }
                    }
                    .padding(.top)
                    
                    // New HW Button and Calendar Button
                    HStack {
                        Button(action: {
                            viewModel.isShowingCalendarView = true
                            
                        }, label: {
                            ToCalendarButton()
                                .padding(.leading, 15)
                                .padding(.top)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.isShowingNewAssignmentView = true
                        }, label: {
                            AddHWButton()
                                .padding(.trailing, 15)
                                .padding(.top)
                        })
                    }
                }
                .onAppear {
                    // Load data when the view appears
                    Task {
                        do {
                            try await assignmentStore.load()
                            try await classStore.load()
                        } catch {
                            print("Error loading data: \(error)")
                        }
                    }
                }
                .onDisappear {
                    // Save data when the view disappears
                    Task {
                        do {
                            try await assignmentStore.save(assignments: viewModel.assignments)
                            try await classStore.save(classes: viewModel.classes)
                        } catch {
                            print("Error saving data: \(error)")
                        }
                    }
                }
                .navigationTitle("All Assignments")
            }
            .blur(radius: viewModel.isShowingNewAssignmentView || viewModel.isShowingAssignmentDetailView || viewModel.isShowingNewClassView || viewModel.isShowingClassDetailView || viewModel.isShowingCalendarView ? 10 : 0)
            .fullScreenCover(isPresented: $viewModel.isShowingCalendarView, content: {
                CalendarView(assignmentWasCompleted: $viewModel.assignmentWasCompleted, isShowingCalendarView: $viewModel.isShowingCalendarView)
            })
            
            if viewModel.isShowingNewAssignmentView {
                NewAssignmentView(isShowingNewAssignmentView: $viewModel.isShowingNewAssignmentView)
            }
            if viewModel.isShowingAssignmentDetailView {
                AssignmentDetailView(assignment: viewModel.selectedAssignment, isShowingAssignmentDetailView: $viewModel.isShowingAssignmentDetailView, isShowingEditAssignmentView: $viewModel.isShowingEditAssignmentView)
            }
            if viewModel.isShowingNewClassView {
                NewClassView(isShowingNewClassView: $viewModel.isShowingNewClassView)
            }
            if viewModel.isShowingClassDetailView {
                ClassDetailView(Class: viewModel.selectedClass, isShowingClassDetailView: $viewModel.isShowingClassDetailView, isShowingEditClassView: $viewModel.isShowingEditClassView)
            }
        }
    }
}


#Preview {
    HomePageView()
}
