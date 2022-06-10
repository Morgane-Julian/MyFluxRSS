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
    @State private var isShowingFeedView = false
    @State private var isShowingAuthView = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                NavigationLink(destination: NewsFeedView(newsFeedViewModel: NewsFeedViewModel()), isActive: $isShowingFeedView) { EmptyView() }
                Button("INSCRIPTION") {
                    registerViewModel.inscription { result in
                        self.isShowingFeedView = result
                    }
                }
                .padding(20)
                .background(LinearGradient(gradient: Gradient(colors: [ColorUtils.purple.opacity(0.5), ColorUtils.turquoise.opacity(0.5)]), startPoint:  .top, endPoint: .bottom))
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
