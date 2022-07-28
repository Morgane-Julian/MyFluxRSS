//
//  FluxListView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import SwiftUI

struct FluxListView: View {
    
    @StateObject var parametersViewModel: ParametersViewModel
    
    var body: some View {
        List {
            ForEach(parametersViewModel.myFlux) { item in
                Text("\(item.flux)")
            }.onDelete { indexSet in
                parametersViewModel.delete(at: indexSet)
            }
            .onAppear {
                parametersViewModel.getFlux()
            }
        }
    }
}

struct FluxListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 13 Pro Max"], id: \.self) {
            FluxListView(parametersViewModel: ParametersViewModel())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
            //                .preferredColorScheme(.dark)
        }
    }
}
