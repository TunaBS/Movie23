//
//  RegisterViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class RegisterViewController: UIViewController {

    private let headerView = HeaderView(title: "Welcome", subTitle: "Create a new account")
    private let userNameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let signUp = CustomButton(title: "Create an account", hasBackground: true, fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.signUp.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(userNameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUp)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        userNameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signUp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 270),
            
            self.userNameField.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 30),
            self.userNameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.userNameField.heightAnchor.constraint(equalToConstant: 55),
            self.userNameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 20),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signUp.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 80),
            self.signUp.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signUp.heightAnchor.constraint(equalToConstant: 55),
            self.signUp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc func didTapSignUp() {
        let userName = self.userNameField.text ?? ""
        let email = self.emailField.text ?? ""
        let password = self.passwordField.text ?? ""
        Task {
            try await AuthenticationManager.shared.createUser(userName: userName, email: email, password: password)
        }
    }
}
