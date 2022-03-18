//
//  RegisterView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import SwiftUI

struct RegisterView: View {
    // 1.
    @Binding var showModal: Bool
    @StateObject var registerViewModel: RegisterViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showModal.toggle()
                }) { Label("", systemImage: "multiply")
                        .foregroundColor(Color.purple)
                }
            }.frame(width: UIScreen.main.bounds.size.width, height: 50, alignment: .trailing)
            Spacer()
            Form {
                TextField("Nom", text: $registerViewModel.firstName)
                TextField("Prénom", text: $registerViewModel.lastName)
                DatePicker("Date de naissance", selection: $registerViewModel.birthday, displayedComponents: .date)
                TextField("Email", text: $registerViewModel.email)
                TextField("Mot de passe", text: $registerViewModel.password)
                TextField("Confirmer le mot de passe", text: $registerViewModel.passwordSecurity)
            }
            Button("INSCRIPTION") {
                self.showModal.toggle()
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [ColorManager.purple.opacity(0.5), ColorManager.turquoise.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(80.0)
            Spacer()
            .frame(height: 20)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showModal: .constant(true), registerViewModel: RegisterViewModel())
    }
}
