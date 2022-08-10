//
//  Flux.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 12/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Flux: Identifiable, Codable {
    
    //MARK: - Properties
    
    @DocumentID var id: String?
    var flux = ""
    var userId = ""
}
