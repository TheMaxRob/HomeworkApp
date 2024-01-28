//
//  NewClassView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct NewClassView: View {
    
    @StateObject var viewModel = NewClassViewModel()
    @Binding var isShowingNewClassView: Bool
    
    
    // TODO: FocusedField
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section("New Class") {
                    TextField("Class Name", text: $viewModel.selectedName)
                    TextField("Professor", text: $viewModel.selectedProfessor)
                    TextField("Location", text: $viewModel.selectedLocation)
                    
                    ColorPicker("Class Color", selection: $viewModel.selectedColor)
                    
                    Button(action: {
                        // Create new assignment and add it to data
                        let newClass = Class(name: viewModel.selectedName,
                                             professor: viewModel.selectedProfessor,
                                             location: viewModel.selectedLocation,
                                             color: CodableColor(viewModel.selectedColor))
                        
                        ClassesData.classes.append(newClass)
                        isShowingNewClassView = false
                    }, label: {
                        Text("Create Class")
                    })
                }
            }
            .frame(width: 300, height: 300)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 40)
            .overlay(Button {
                isShowingNewClassView = false
            } label: {
                DismissButton()
                    .padding(.top, 15)
                    .padding(.trailing, 15)
            }, alignment: .topTrailing)
        }
        
        
    }
}

#Preview {
    NewClassView(isShowingNewClassView: .constant(true))
}
