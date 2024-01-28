//
//  CompleteButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct CheckMarkButton: View {
    var body: some View {
        Image(systemName: "checkmark")
            .opacity(0.3)
            .frame(width: 35, height: 35)
            .overlay(
                Circle()
                    .stroke(.gray, lineWidth: 2)
                    .opacity(0.3))
    }
}

#Preview {
    CheckMarkButton()
}
