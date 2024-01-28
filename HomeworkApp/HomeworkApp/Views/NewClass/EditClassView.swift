//
//  EditClassView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI

struct EditClassView: View {
    
    @StateObject var viewModel = NewClassViewModel()
    @Binding var isShowingClassDetailView: Bool
    @Binding var isShowingEditClassView: Bool
    var thisClass: Class
    
    // TODO: Actually make the changes happen when you press Save Changes and not crash the app 
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section("Edit Class") {
                    TextField("\(thisClass.name)", text: $viewModel.selectedName)
                    TextField("\(thisClass.professor)", text: $viewModel.selectedProfessor)
                    TextField("\(thisClass.location)", text: $viewModel.selectedLocation)
                    
                    ColorPicker("Class Color", selection: $viewModel.selectedColor)
                    
                    Button(action: {
                        // Edit thisClass - easier to just leave it here than be a function
                        let newClass = Class(name: viewModel.selectedName, professor: viewModel.selectedProfessor, location: viewModel.selectedLocation, color: CodableColor(viewModel.selectedColor))
                        
                        let index = ClassesData.classes.firstIndex { element in
                            thisClass.name == element.name
                        }
                        ClassesData.classes[index ?? 0] = newClass
                        isShowingEditClassView = false
                        isShowingClassDetailView = false
                        print(ClassesData.classes)
                    }, label: {
                        Text("Save Changes")
                    })
                }
            }
            .frame(width: 300, height: 300)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 40)
            .overlay(Button {
                isShowingEditClassView = false
            } label: {
                DismissButton()
                    .padding(.top, 15)
                    .padding(.trailing, 15)
            }, alignment: .topTrailing)
        }
        
        
    }
}

#Preview {
    EditClassView(isShowingClassDetailView: .constant(true), isShowingEditClassView: .constant(true), thisClass: MyData.sampleClass)
}
