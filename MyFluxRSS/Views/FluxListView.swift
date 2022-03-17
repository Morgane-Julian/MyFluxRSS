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
            }
        }
    }
}

struct FluxListView_Previews: PreviewProvider {
    static var previews: some View {
        FluxListView(parametersViewModel: ParametersViewModel())
    }
}
