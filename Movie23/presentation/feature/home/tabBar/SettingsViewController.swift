
//  SettingsViewController.swift
//  Movie23
//
//  Created by BS00880 on 3/7/24.
//

import UIKit

class SettingsViewController: UIViewController {

    let headerView = HeaderView(title: "Settings")
    var userInfoBox = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        userInfoBox = showUserInfo(to: view, userName: "Fairuz", email: "fairuz@gmail.com")
        addSubViews()
        setUpUI()
    }
    
    private func addSubViews() {
        view.addSubview(headerView)
        view.addSubview(userInfoBox)
    }
    private func setUpUI() {
        headerView.pinToRightAndBottomOfSomething(height: 10, to: self.view, to: nil, to: nil, topPlace: true)
        userInfoBox.pinToRightAndBottomOfSomething(height: 50, to: self.view, to: nil, to: headerView)
    }
    
    private func showUserInfo(to superView: UIView, userName: String, email: String) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(userNameLabel)
        
        let emailLabel = UILabel()
        emailLabel.text = email
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(emailLabel)
        
        superView.addSubview(fullView)
        
        userNameLabel.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
        
        fullView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.8).isActive = true
        
        let paddedView = createPaddedContainer(for: fullView, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        return paddedView
    }
    
    private func showSupports() {
        
    }
    
    private func showButtons() {
        
    }
}
