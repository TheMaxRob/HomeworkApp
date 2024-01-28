//
//  AssignmentContainerView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct AssignmentListItem: View {
    
    var assignment: Assignment
    @Binding var assignmentWasCompleted: Bool
    
    var body: some View {
        HStack {
            DatePin(assignment: assignment)
                .padding(.leading)
            VStack(alignment: .leading) {
                Text("\(assignment.name)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    //.foregroundStyle(assignment._class.color)
                    
                    
            }
            Spacer()
            
            Button(action: {
                Assignment.completeAssignment(assignment: assignment)
                assignmentWasCompleted.toggle()
            }, label: {
                CheckMarkButton()
                    .padding(.trailing, 30)
            })
            
        }
    }
}

#Preview {
    AssignmentListItem(assignment: MyData.sampleAssignment, assignmentWasCompleted: .constant(false))
}
