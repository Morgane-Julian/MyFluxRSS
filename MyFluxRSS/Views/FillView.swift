//
//  FillView.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

struct FillView: View {
    
    var fillViewModel: FillViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fillViewModel) { item in
                    ArticleView(article: item)
                }
            }
        }
    }
}

#if DEBUG
struct FillView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 13 Pro Max"], id: \.self) {
            FillView(fillViewModel: FillViewModel())
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
//                .preferredColorScheme(.dark)
        }
    }
}
#endif
