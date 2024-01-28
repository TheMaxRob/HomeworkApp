//
//  DayDetailsView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI

struct DayDetailsView: View {
    
    let day: Date
    @Binding var assignmentWasCompleted: Bool
    @Binding var isShowingDayDetailView: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Your Assignments")
                    .navigationTitle("\(Date.getWeekdayString(date: day)), \(Date.monthString(date: day)) \(Date.formatDateDay(date: day))")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                
                let assignmentsForDay = AssignmentData.assignments.filter { Calendar.current.isDate($0.dueDate, inSameDayAs: day)
                }
                
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(assignmentsForDay) { assignment in
                            AssignmentListItem(assignment: assignment, assignmentWasCompleted: $assignmentWasCompleted)
                        }
                    }
                }
            }
            .frame(width: 300, height: 300)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
            .overlay(Button {
                isShowingDayDetailView = false
            } label: {
                DismissButton()
                    .padding(35)
            }, alignment: .topTrailing)
        }
        
        
        
       
        
        
    }
}

#Preview {
    DayDetailsView(day: Date(), assignmentWasCompleted: .constant(false), isShowingDayDetailView: .constant(false))
}
