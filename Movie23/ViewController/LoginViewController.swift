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
    private let signInWithGoogle = CustomButton(title: "Sign In with Google", hasBackground: false, fontSize: .big)
    private let newUser = CustomButton(title: "Don't have an account? Create one", fontSize: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUser.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
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
        self.view.addSubview(signInWithGoogle)
        self.view.addSubview(newUser)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInWithGoogle.translatesAutoresizingMaskIntoConstraints = false
        newUser.translatesAutoresizingMaskIntoConstraints = false
        
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
     
            self.signInWithGoogle.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            self.signInWithGoogle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInWithGoogle.heightAnchor.constraint(equalToConstant: 55),
            self.signInWithGoogle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.newUser.topAnchor.constraint(equalTo: signInWithGoogle.bottomAnchor, constant: 20),
            self.newUser.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.newUser.heightAnchor.constraint(equalToConstant: 55),
            self.newUser.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func didTapSignIn() {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        Task {
            try await AuthenticationManager.shared.signIn(email: email, password: password)
        }
        
        let vc = HomeViewController()
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: false, completion: nil)
    }
    
    @objc private func didTapNewUser() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
