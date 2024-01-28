//
//  CalendarView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI

struct CalendarView: View {
    
    // MARK: Maybe add some kind of "assignment days" to the view model?
    @StateObject var viewModel = CalendarViewModel()
    @Binding var assignmentWasCompleted: Bool
    @Binding var isShowingCalendarView: Bool
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                VStack {
                    // Left and Right Arrows
                    HStack {
                        Button(action: {
                            viewModel.updateMonth(increment: -1)
                        }, label: {
                           LeftRightButton(direction: "left")
                                .offset(y: -4)
                        })
                        
                        Text("\(Date.monthString(date: viewModel.date))")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.updateMonth(increment: 1)
                        }, label: {
                            LeftRightButton(direction: "right")
                                .offset(y: -4)
                        })
                    }
                    
                    // Days of week
                    HStack {
                        ForEach(days, id: \.self) { day in
                            Text(day)
                                .font(.system(size: 12, weight: .medium))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    
                    // Calendar numbers
                    LazyVGrid(columns: Array(repeating: GridItem(), count: days.count), content: {
                        let datesOfMonth = viewModel.date.datesOfMonth()
                       
                        let firstDayOfWeekday = Date.getWeekdayComponent(date: datesOfMonth.first ?? Date())

                        // Add empty cells before the 1st day to align the grid
                        ForEach(0..<firstDayOfWeekday-1, id: \.self) { _ in
                            Text("")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        
                        ForEach(datesOfMonth, id: \.self) { date in
                            if AssignmentData.assignments.contains(where: { assignment in
                                assignment.dueDate.formatted(date: .abbreviated, time: .omitted) == date.formatted(date: .abbreviated, time: .omitted)}) {
                                CalendarGridView(day: date)
                                    
                                    .onTapGesture {
                                        viewModel.isShowingDayDetailView = true
                                        viewModel.selectedDay = date
                                    }
                                
                            }
                            CalendarGridView(day: date)
                                .onTapGesture {
                                    viewModel.isShowingDayDetailView = true
                                    viewModel.selectedDay = date
                                }
                        }
                    })
                }
                .blur(radius: viewModel.isShowingDayDetailView ? 10 : 0)
                .navigationTitle("Your Calendar")
            }
            .overlay(Button {
                isShowingCalendarView = false
            } label: {
                VStack {
                    Image(systemName: "house.fill")
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                        .offset(y: 15)
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                    Text("Home")
                        .offset(y: 12)
                        .foregroundStyle(.black)
                        .font(.footnote)
                }
                
            }, alignment: .topTrailing)
            
            
            if viewModel.isShowingDayDetailView {
                DayDetailsView(day: viewModel.selectedDay, assignmentWasCompleted: $assignmentWasCompleted, isShowingDayDetailView: $viewModel.isShowingDayDetailView)
            }
        }
       
    }


    
}

#Preview {
    CalendarView(assignmentWasCompleted: .constant(false), isShowingCalendarView: .constant(true))
}

extension Date {
    
    func datesOfMonth() -> [Date] {
            let calendar = Calendar.current
            let currentDateComponents = calendar.dateComponents([.year, .month], from: self)
            
            guard let startOfMonth = calendar.date(from: currentDateComponents),
                  let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
                return []
            }
            
            var dates: [Date] = []
            var currentDate = startOfMonth
            
            while currentDate <= endOfMonth {
                dates.append(currentDate)
                guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                    break
                }
                currentDate = nextDate
            }
            
            return dates
        }
    
    
    static func formatDateDay(date: Date) -> Int {
        let calendar = Calendar.current

        return calendar.component(.day, from: date)
    }
    
    
    static func getWeekdayComponent(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: date)
    }
    
    static func getWeekdayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // for the full name of the day of the week
        return dateFormatter.string(from: Date())
    }
    
    
    static func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        return dateFormatter.string(from: date)
    }
}


