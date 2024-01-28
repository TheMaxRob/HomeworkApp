//
//  ClassDetailView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct ClassDetailView: View {
    let Class: Class
    @Binding var isShowingClassDetailView: Bool
    @Binding var isShowingEditClassView: Bool
    
    @StateObject var viewModel = ClassDetailViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    isShowingClassDetailView = false
                } label: {
                    DismissButton()
                        .padding(.top, 20)
                }
                HStack {
                    Text("\(Class.name)")
                        .padding(.bottom, 5)
                        .padding(.top, 10)
                        .font(.title)
                        
                    Button(action: {
                        isShowingEditClassView = true
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                            
                    })
                    Spacer()
                }
                Text("Class: \(Class.professor)")
                Text("Location: \(Class.location)")
                Text("Color: \(Class.color.uiColor.description)")
                    
                Spacer()
                
            }
            .padding(.leading, 20)
            .frame(width: 350, height: 230)
            .background(Class.color.uiColor.opacity(0.7))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .navigationTitle("Class Details")
            .overlay(Button {
                viewModel.isShowingConfirmClassDeletionView = true
            } label: {
                TrashButton()
                    .padding(.init(top: 15, leading: 0, bottom: 0, trailing: 20))
            }, alignment: .topTrailing)
            .blur(radius: viewModel.isShowingConfirmClassDeletionView ? 10 : 0)
            .blur(radius: isShowingEditClassView ? 10 : 0)
        }
        if viewModel.isShowingConfirmClassDeletionView {
            ConfirmClassDeletionView(Class: Class, isShowingConfirmClassDeletionView: $viewModel.isShowingConfirmClassDeletionView, isShowingClassDetailView: $isShowingClassDetailView)
        }
        if isShowingEditClassView {
            EditClassView(isShowingClassDetailView: $isShowingClassDetailView, isShowingEditClassView: $isShowingEditClassView, thisClass: Class)
        }
    }
}

#Preview {
    ClassDetailView(Class: MyData.sampleClass, isShowingClassDetailView: .constant(true), isShowingEditClassView: .constant(false))
}
