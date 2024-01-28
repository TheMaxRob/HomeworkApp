//
//  NewHWViewModel.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

final class NewHWViewModel: ObservableObject {
    @Published var assignment: Assignment = Assignment(name: "", Class: Class(name: "", professor: "", location: "", color: CodableColor(Color(.systemBackground))), dueDate: Date(), priority: .low, info: "")
}
