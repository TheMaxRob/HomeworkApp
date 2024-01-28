//
//  CalendarGridView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/27/24.
//

import SwiftUI

struct CalendarGridView: View {
    
    let day: Date
    var classes: [Class]
    
    var body: some View {
        Text("\(Date.formatDateDay(date: day))")
            .frame(width: 25, height: 25)
            .contentShape(.rect(cornerSize: .init(width: 10, height: 10)))
            .padding(.vertical)
        
        HStack {
            ForEach(classes) { Class in
                ColorCircle(color: Class.color.uiColor)
            }
        }
    }
}

#Preview {
    CalendarGridView(day: Date(), classes: [])
}
