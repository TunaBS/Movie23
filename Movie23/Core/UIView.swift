//
//  UIView.swift
//  Movie23
//
//  Created by BS00880 on 26/6/24.
//

import Foundation
import UIKit

extension UIView {
    
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor)
        leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    }
    
}
