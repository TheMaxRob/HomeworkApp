//
//  ColorCircle.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/27/24.
//

import SwiftUI

struct ColorCircle: View {
    
    let color: Color
    
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundStyle(color)
    }
}

#Preview {
    ColorCircle(color: .blue)
}
