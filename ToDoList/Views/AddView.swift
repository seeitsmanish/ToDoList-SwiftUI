//
//  AddView.swift
//  ToDoList
//
//  Created by Manish Sharma on 27/06/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here ....", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action : saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an Item 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        if textIsAppropriate() {
            listViewModel.addItems(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at atleast 3 characters long!!!😨"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() ->Alert {
        return Alert(title: Text(alertTitle))
    }
    
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            AddView()
        }
        .preferredColorScheme(.light)
        .environmentObject(ListViewModel())
        
        NavigationView{
            AddView()
        }
        .preferredColorScheme(.dark)
        .environmentObject(ListViewModel())
        
    }
}
