//
//  ContentView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct ContentView: View {
    
     var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                    Spacer()
                    .frame(height: 70)
            }
            VStack {
                TextField("Identifiant", text: viewModel.$userName)
                    .padding()
                    .background(ColorManager.lightGray)
                    .cornerRadius(5.0)
                    .padding()
                SecureField("Mot de passe", text: viewModel.$password)
                    .padding()
                    .background(ColorManager.lightGray)
                    .cornerRadius(5.0)
                    .padding()
                HStack {
                    Button("") {
                        viewModel.keepMeLog()
                    }
                    .padding()
                    .border(.purple, width: 3)
                    .frame(width: 3, height: 3, alignment: .trailing)
                    Text("Mémoriser mes identifiants")
                        .padding()
                }
                Spacer()
            }
            VStack {
                Button("CONNEXION") {
                    viewModel.connect()
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [ColorManager.purple.opacity(0.5), ColorManager.turquoise.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(5.0)
                Spacer()
                    .frame(height: 20)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 13 Pro Max"], id: \.self) {
            ContentView(viewModel: ContentViewModel.init())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
//                .preferredColorScheme(.dark)
        }
    }
}
#endif
