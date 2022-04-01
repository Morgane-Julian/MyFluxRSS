//
//  RegisterView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 18/03/2022.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerViewModel: RegisterViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingDetailView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Nom", text: $registerViewModel.firstName)
                    TextField("Prénom", text: $registerViewModel.lastName)
                    DatePicker("Date de naissance", selection: $registerViewModel.birthday, displayedComponents: .date)
                    TextField("Email", text: $registerViewModel.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    SecureField("Mot de passe", text: $registerViewModel.password)
                    SecureField("Confirmer le mot de passe", text: $registerViewModel.passwordSecurity)
                }
                Spacer()
                    
                NavigationLink(destination: NewsFeedView(newsFeedViewModel: NewsFeedViewModel()), isActive: $isShowingDetailView) { EmptyView() }
                
                Button("INSCRIPTION") {
                    registerViewModel.inscription()
                    if registerViewModel.isSignedIn {
                        isShowingDetailView = true
                    }
                } .padding(20)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.purple.opacity(0.5), ColorManager.turquoise.opacity(0.5)]), startPoint:  .top, endPoint: .bottom))
                    .cornerRadius(80.0)
                Spacer()
                    .frame(width: 20, height: 50, alignment: .center)
            }
            .background(Color.gray.opacity(0.1))
        } .navigationBarHidden(true)
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
