//
//  ConfirmClassDeletionView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct ConfirmClassDeletionView: View {
    
    var Class: Class
    @Binding var isShowingConfirmClassDeletionView: Bool
    @Binding var isShowingClassDetailView: Bool
    
    var body: some View {
        VStack {
            Text("Delete Class")
                .font(.title)
                .padding(.bottom, 3)
            Text("Are you sure you want to delete: ")
                .padding(.bottom, 6)
            Text("\(Class.name)")
                .fontWeight(.semibold)
                .font(.title3)
            HStack {
                Button(action: {
                    isShowingConfirmClassDeletionView = false
                }, label: {
                    CancelButton()
                })
                Button(action: {
                    Class.deleteClass(Class: Class)
                    isShowingConfirmClassDeletionView = false
                    isShowingClassDetailView = false
                }, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 115, height: 40)
                        .foregroundStyle(.red)
                        .overlay {
                            Text("Confirm")
                                .foregroundStyle(.white)
                        }
                })
            }
        }
        .frame(width: 300, height: 200)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 40)
    }
}

#Preview {
    ConfirmClassDeletionView(Class: MyData.sampleClass, isShowingConfirmClassDeletionView: .constant(true), isShowingClassDetailView: .constant(true))
}
