//
//  ColorManager.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import Foundation
import SwiftUI

struct ColorUtils {
    static let pink = Color("pink")
    static let lightGray = Color("lightGray")
    static let purple = Color("purple")
    static let turquoise = Color("turquoise")
    
}

extension Color {
    
    static var BackgroundColor: Color  {
        return Color("BackgroundColor")
    }
    static var BackgroundColorList: Color  {
        return Color("BackgroundColorList")
    }
    static var ColorPrimary: Color  {
        return Color("ColorPrimary")
    }
    static var TextColorPrimary: Color  {
        return Color("TextColorPrimary")
    }
    static var BackgroundColorTextfield: Color  {
        return Color("BackgroundColorTextfield")
    }
}
