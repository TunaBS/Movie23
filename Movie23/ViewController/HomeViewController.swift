//
//  HomeViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class HomeViewController: UIViewController {

    private let headerView = HeaderView(title: "Welcome", subTitle: "Home Page"/*, backgroundColor: .red*/)
    private let topMoviePicksText = HeaderView(title: "Top Movie Picks"/*, backgroundColor: .green*/)
    private let upComingMoviePicksText = HeaderView(title: "Up coming Movie Picks"/*, backgroundColor: .green*/)
    private let seeAllButtonWithTopMovie = CustomButton(title: "See all", fontSize: .small, titleColor: .darkText)
    private let seeAllButtonWithUpcomingMovie = CustomButton(title: "See all", fontSize: .small, titleColor: .darkText)
    private let logOutButton = CustomButton(title: "Log out", hasBackground: false, fontSize: .small, titleColor: .red)
    private let deleteAccountButton = CustomButton(title: "Delete Account", hasBackground: false, fontSize: .small, titleColor: .red)
    let movieListPlaceholderTopMovie = UIView()
    let movieListPlaceholderUpcomingMovie = UIView()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupMovieListViewController(to: topMoviePicksText)
        self.setupMovieListViewController(to: upComingMoviePicksText)
        self.logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.deleteAccountButton.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
        self.seeAllButtonWithTopMovie.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        self.seeAllButtonWithUpcomingMovie.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
    }

    private func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(topMoviePicksText)
        self.view.addSubview(upComingMoviePicksText)
        self.view.addSubview(logOutButton)
        self.view.addSubview(deleteAccountButton)
        self.view.addSubview(seeAllButtonWithTopMovie)
        self.view.addSubview(seeAllButtonWithUpcomingMovie)
        self.view.addSubview(movieListPlaceholderTopMovie)
        
        headerView.pinToTheRightAndBottomOfSomething(height: 0.08, to: view, to: nil, to: nil, topPlace: true)
        topMoviePicksText.pinToTheRightAndBottomOfSomething(height: 0.05, to: view, to: nil, to: headerView)
        upComingMoviePicksText.pinToTheRightAndBottomOfSomething(height: 0.05, to: view, to: nil, to: movieListPlaceholderTopMovie)
        movieListPlaceholderTopMovie.pinToTheRightAndBottomOfSomething(height: 0.5, to: view)
        seeAllButtonWithTopMovie.pinButtonToBottomOfSomethingTrailing(to: view, to: topMoviePicksText)
        seeAllButtonWithUpcomingMovie.pinButtonToBottomOfSomethingTrailing(to: view, to: upComingMoviePicksText)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
    
    private func setupMovieListViewController(to bottomOf: UIView) {
        let movieListVC = TopMovieViewController()
        
        self.addChild(movieListVC)
        self.view.addSubview(movieListVC.view)
        movieListVC.didMove(toParent: self)
        
        movieListVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieListVC.view.topAnchor.constraint(equalTo: /*self.*/bottomOf.bottomAnchor),
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
