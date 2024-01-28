//
//  ClassSideButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

struct ClassSideButton: View {
    
    let Class: Class
    
    var body: some View {
        UnevenRoundedRectangle()
            .overlay {
                Text("\(Class.name)")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 5)
                    .opacity(0.8)
            }
            .clipShape(.rect(cornerRadii: .init(topLeading: 20, bottomLeading: 20)))
            .frame(width: 85, height: 35)
            .foregroundStyle(Class.color.uiColor.opacity(0.7))
            .lineLimit(1)
            .minimumScaleFactor(0.9)
    }
}

#Preview {
    ClassSideButton(Class: MyData.sampleClass)
}
