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
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func pinButtonToBottomTrailing(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -5).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10).isActive = true
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func pinToTheRightAndBottomOfSomething(to superview: UIView, to leftview: UIView? = nil, to upview: UIView? = nil){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: upview?.bottomAnchor ?? superview.topAnchor, constant: 10).isActive = true
        leadingAnchor.constraint(equalTo: leftview?.trailingAnchor ?? superview.leadingAnchor, constant: 10).isActive = true
        heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupRoundedCorners(for label: PaddedLabel) {
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
