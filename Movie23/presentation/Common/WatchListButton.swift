//
//  WatchListButton.swift
//  Movie23
//
//  Created by BS00880 on 8/7/24.
//

import UIKit

class WatchListButton: UIButton {
    
    var isFavourite: Bool {
        didSet {
            updateAppearance()
        }
    }
        
    var onToggleFavourite: (() -> Void)?
    
    var title = ""

    enum FontSize {
        case big
        case medium
        case small
    }
    
    private func updateAppearance() {
        title = isFavourite ? "Remove from Watch List" : "Add to Watch List"
    }
    
    init(isFavourite: Bool, onToggleFavourite: @escaping () -> Void, hasBackground: Bool = false, fontSize: FontSize, titleColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        self.isFavourite = isFavourite
        self.onToggleFavourite = onToggleFavourite
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = backgroundColor ?? (hasBackground ? .systemPurple : .clear)
        
        // Use provided title color if any, otherwise use default
        let finalTitleColor: UIColor = titleColor ?? (hasBackground ? .white : .systemPurple)
        self.setTitleColor(finalTitleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
            
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        guard let viewController = self.findViewController() else { return }
        var alertTitle = ""
        var alertMessage = ""
        if isFavourite == true {
            alertTitle = "Movie Removed"
            alertMessage = "You have removed this movie from your watch list"
        } else {
            alertTitle = "Movie Added"
            alertMessage = "You have saved this movie to your watch list"
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        isFavourite.toggle()
        onToggleFavourite?()
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}

