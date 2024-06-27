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
        
//        movieTitle.translatesAutoresizingMaskIntoConstraints = false
////        movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
//        movieTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        movieTitle.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 5).isActive = true
    }
}
