//
//  DatePin.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct DatePin: View {
    
    let assignment: Assignment
    
    var body: some View {
        let formattedDateDay = assignment.formatDateDay(date: assignment.dueDate)
        let formattedDateMonth = assignment.formatDateMonth(date: assignment.dueDate)
        VStack(spacing: 0) {
            Text("\(formattedDateDay)")
                .font(.title2)
                .fontWeight(.bold)
            Text("\(formattedDateMonth)")
                .font(.callout)
        }
        .frame(width: 60, height: 60)
        .foregroundStyle(.white)
        .background(assignment.priority.color.opacity(0.7))
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DatePin(assignment: MyData.sampleAssignment)
}
