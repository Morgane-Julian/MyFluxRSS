//
//  Article.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 12/05/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Article: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var userId = ""
    var title: String = "Title"
    var image = "logo"
    var description: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var date: String = ""
    var from: String = "Youtube"
    var link: String = ""
}
