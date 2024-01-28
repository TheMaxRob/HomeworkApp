//
//  HomeworkAppApp.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

@main
struct HomeworkApp: App {
    
    var assignmentsStore = AssignmentStore()
    var classesStore = ClassStore()
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environment(assignmentsStore)
                .environment(classesStore)
        }
    }
}
