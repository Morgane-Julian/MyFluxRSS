//
//  FillViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation
import SwiftUI

class FillViewModel: ObservableObject, RandomAccessCollection {
    
    @State var articles : [Article] = []
    
    var startIndex: Int { articles.startIndex }
    var endIndex: Int { articles.endIndex }
    func formIndex(after i: inout Int) { i += 1 }
    func formIndex(before i: inout Int) { i -= 1 }
    
    subscript(index: Int) -> Article {
        return articles[index]
    }
    
    
}


class Article: Identifiable {
    var id: UUID = .init()
    var title: String = "Title"
    var image = UIImage(named: "logo")
    var description: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var date: String = "2022/03/03"
    var from: String = "Youtube"
}
