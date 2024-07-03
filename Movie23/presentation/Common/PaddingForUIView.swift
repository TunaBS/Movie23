//
//  PaddingForUIView.swift
//  Movie23
//
//  Created by BS00880 on 3/7/24.
//

import Foundation
import UIKit


func createPaddedContainer(for view: UIView, padding: UIEdgeInsets) -> UIView {
    
    let containerView = UIView()
    containerView.backgroundColor = .yellow
    containerView.translatesAutoresizingMaskIntoConstraints = false

    // Add the view to the container view
    containerView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false

    // Set constraints to add padding around the view
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding.top),
        view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding.bottom),
        view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding.left),
        view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding.right)
    ])

    return containerView
}

