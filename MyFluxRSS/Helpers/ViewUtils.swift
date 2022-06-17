//
//  ViewUtils.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/06/2022.
//

import Foundation
import SwiftUI

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
