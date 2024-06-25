//
//  HomeViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class HomeViewController: UIViewController {

    private let headerView = HeaderView(title: "Welcome", subTitle: "Home Page")
    private let topMoviePicksText = HeaderView(title: "Top Movie Picks")
    private let moviePosterView = MoviePosterView(title: "Movie name", subTitle: "Year")
    private let logOutButton = CustomButton(title: "Log out", hasBackground: false, fontSize: .small, titleColor: .red)
    private let deleteAccountButton = CustomButton(title: "Delete Account", hasBackground: false, fontSize: .small, titleColor: .red)
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupMovieListViewController()
        self.logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.deleteAccountButton.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
    }

    private func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(moviePosterView)
        self.view.addSubview(topMoviePicksText)
        self.view.addSubview(logOutButton)
        self.view.addSubview(deleteAccountButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        topMoviePicksText.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 270),
            
            self.topMoviePicksText.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 80),
            self.topMoviePicksText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.topMoviePicksText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topMoviePicksText.heightAnchor.constraint(equalToConstant: 250),
            
            self.moviePosterView.topAnchor.constraint(equalTo: self.topMoviePicksText.topAnchor, constant: 5),
            self.moviePosterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviePosterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviePosterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            self.logOutButton.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 200),
            self.logOutButton.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.logOutButton.heightAnchor.constraint(equalToConstant: 55),
            
            self.deleteAccountButton.topAnchor.constraint(equalTo: self.logOutButton.bottomAnchor, constant: 20),
            self.deleteAccountButton.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.deleteAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.deleteAccountButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupMovieListViewController() {
        let movieListVC = TopMovieViewController()
        
        // Add movieListVC as a child view controller
        self.addChild(movieListVC)
        self.view.addSubview(movieListVC.view)
        movieListVC.didMove(toParent: self)
        
        // Set up constraints for movieListVC's view
        movieListVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieListVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            movieListVC.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            movieListVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            movieListVC.view.heightAnchor.constraint(equalToConstant: 200) // Adjust height as needed
        ])
    }
    
    @objc private func didTapLogOut() {
        Task {
            try await AuthenticationManager.shared.signOut()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkSignInUser()
                print("into scene delegate")
            }
        }
        
    }
    
    @objc private func didTapDeleteAccount() {
        Task {
            try await AuthenticationManager.shared.deleteAccount()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkSignInUser()
                print("into scene delegate")
            }
        }
    }
    
}
