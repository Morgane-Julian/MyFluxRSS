//
//  ParametersViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation

class ParametersViewModel: ObservableObject {
  
    @Published var theme = ["dark", "light", "system"]
    @Published var myFlux = [Flux()]
    @Published var urlString = ""
    @Published var facebook = true
    @Published var reddit = false
    @Published var youtube = true
    @Published var twitter = true
    @Published var notifications = true
    @Published var previewOptions = ["Always", "When Unlocked", "Never"]
    
    func addNewFlux(link: String) {
        let myNewFlux : Flux = Flux()
        myNewFlux.flux = link
        self.myFlux.append(myNewFlux)
        }
    }

class Flux: Identifiable {
    var flux = "unfluxdequalité"
}
