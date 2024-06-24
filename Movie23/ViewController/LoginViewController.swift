//
//  LoginViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class LoginViewController: UIViewController {
    private let headerView = HeaderView(title: "Welcome Back", subTitle: "Sign in to your account")
        
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let signInWithGoogle = CustomButton(title: "Sign In with Google", hasBackground: true, fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 270),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 80),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInWithGoogle.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 80),
            self.signInWithGoogle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInWithGoogle.heightAnchor.constraint(equalToConstant: 55),
            self.signInWithGoogle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
        ])
    }
}
