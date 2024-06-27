//
//  HomeViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class HomeViewController: UIViewController {

    private let headerView = HeaderView(title: "Welcome", subTitle: "Home Page", backgroundColor: .red)
    private let topMoviePicksText = HeaderView(title: "Top Movie Picks", backgroundColor: .green)
    private let upComingMoviePicksText = HeaderView(title: "Up coming Movie Picks", backgroundColor: .green)
    private let movieListButton = CustomButton(title: "See all", fontSize: .small, titleColor: .darkText)
    private let logOutButton = CustomButton(title: "Log out", hasBackground: false, fontSize: .small, titleColor: .red)
    private let deleteAccountButton = CustomButton(title: "Delete Account", hasBackground: false, fontSize: .small, titleColor: .red)
    let movieListPlaceholder = UIView()

    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupMovieListViewController()
        self.logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.deleteAccountButton.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
        self.movieListButton.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
    }

    private func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(topMoviePicksText)
        self.view.addSubview(upComingMoviePicksText)
        self.view.addSubview(logOutButton)
        self.view.addSubview(deleteAccountButton)
        self.view.addSubview(movieListButton)
        self.view.addSubview(movieListPlaceholder)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        topMoviePicksText.translatesAutoresizingMaskIntoConstraints = false
        upComingMoviePicksText.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        movieListButton.translatesAutoresizingMaskIntoConstraints = false
        movieListPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        movieListPlaceholder.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            self.headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08),
            
            self.topMoviePicksText.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.topMoviePicksText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            self.topMoviePicksText.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            
            self.movieListPlaceholder.topAnchor.constraint(equalTo: self.topMoviePicksText.bottomAnchor),self.movieListPlaceholder.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.movieListPlaceholder.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.movieListPlaceholder.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25),
            
            self.upComingMoviePicksText.topAnchor.constraint(equalTo:  /*self.*/movieListPlaceholder.bottomAnchor, constant: 5),
            self.upComingMoviePicksText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.upComingMoviePicksText.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            self.upComingMoviePicksText.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            
            self.movieListButton.bottomAnchor.constraint(equalTo: self.logOutButton.bottomAnchor, constant: -20),
            self.movieListButton.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.movieListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.movieListButton.heightAnchor.constraint(equalToConstant: 25),
            
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
        
        self.addChild(movieListVC)
        self.view.addSubview(movieListVC.view)
        movieListVC.didMove(toParent: self)
//        movieListPlaceholder.removeFromSuperview()
        
        movieListVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieListVC.view.topAnchor.constraint(equalTo: /*self.*/topMoviePicksText.bottomAnchor),
            movieListVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            movieListVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            movieListVC.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25)
            
        ])
    }
    
    @objc private func didTapSeeAll() {
        let vc = MovieListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
