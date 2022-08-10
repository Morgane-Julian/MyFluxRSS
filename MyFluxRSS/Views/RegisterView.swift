//
//  RegisterView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import SwiftUI

struct RegisterView: View {
    
    //MARK: - Properties
    
    @StateObject var registerViewModel: RegisterViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingFeedView = false
    @State private var isShowingAuthView = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            
            //MARK: - USER IDENTIFICATION
            
            Form {
                TextField("Nom", text: $registerViewModel.user.firstName)
                TextField("Prénom", text: $registerViewModel.user.lastName)
                DatePicker("Date de naissance", selection: $registerViewModel.user.birthday, displayedComponents: .date)
                    .keyboardType(.numbersAndPunctuation)
                TextField("Email", text: $registerViewModel.user.email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                SecureField("Mot de passe", text: $registerViewModel.user.password)
                SecureField("Confirmer le mot de passe", text: $registerViewModel.user.passwordSecurity)
            }
            Spacer()
            
            //MARK: - MOOVE TO NEWSFEEDVIEW
            
            NavigationLink(destination: NewsFeedView(newsFeedViewModel: NewsFeedViewModel()), isActive: $registerViewModel.isSignedIn) { EmptyView() }
            
            Button("INSCRIPTION") {
                if self.registerViewModel.user.password == self.registerViewModel.user.passwordSecurity {
                    self.registerViewModel.inscription()
                } else {
                    print("Erreur les mots de passe ne sont pas identiques !")
                }
            }
            .padding(20)
            .frame(width: 150, height: 50, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color("ButtonLightGradient").opacity(0.5), Color("ButtonDarkGradient").opacity(0.5)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20.0)
            Spacer()
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            RegisterView(registerViewModel: RegisterViewModel())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
