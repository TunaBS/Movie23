//
//  HomeViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class HomeViewController: UIViewController {

    private let headerView = HeaderView(title: "Welcome", subTitle: "Home Page")
    private let topMoviePicksText = HeaderView(title: "Top Movie Picks", backgroundColor: .green)
    private let upComingMoviePicksText = HeaderView(title: "Up coming Movie Picks", backgroundColor: .cyan)
//    private let moviePosterView = MoviePosterView(title: "Movie name", subTitle: "Year")
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
//        self.view.addSubview(moviePosterView)
        self.view.addSubview(topMoviePicksText)
        self.view.addSubview(upComingMoviePicksText)
        self.view.addSubview(logOutButton)
        self.view.addSubview(deleteAccountButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
//        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        topMoviePicksText.translatesAutoresizingMaskIntoConstraints = false
        upComingMoviePicksText.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 25),
            
            self.topMoviePicksText.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 80),
            self.topMoviePicksText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.topMoviePicksText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topMoviePicksText.heightAnchor.constraint(equalToConstant: 25),
            
            self.upComingMoviePicksText.topAnchor.constraint(equalTo: self.logOutButton.topAnchor, constant: -100),
            self.upComingMoviePicksText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.upComingMoviePicksText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.upComingMoviePicksText.heightAnchor.constraint(equalToConstant: 25),
            
            self.logOutButton.bottomAnchor.constraint(equalTo: self.deleteAccountButton.bottomAnchor, constant: -20),
            self.logOutButton.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.logOutButton.heightAnchor.constraint(equalToConstant: 25),
            
            self.deleteAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            self.deleteAccountButton.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.deleteAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.deleteAccountButton.heightAnchor.constraint(equalToConstant: 25),
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
            movieListVC.view.topAnchor.constraint(equalTo: /*self.*/topMoviePicksText.bottomAnchor, constant: 2),
            movieListVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            movieListVC.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            movieListVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            movieListVC.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25) // Adjust height as needed
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
