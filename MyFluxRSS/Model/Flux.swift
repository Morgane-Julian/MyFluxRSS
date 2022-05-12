//
//  Flux.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 12/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Flux: Identifiable, Codable {
    @DocumentID var id: String?
    var flux = "https://www.hackingwithswift.com/articles/rss"
    var userId = ""
}
