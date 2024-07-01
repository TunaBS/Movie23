//
//  HomeViewController.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
//        sv.backgroundColor = .darkerYellow
        return sv
    } ()
    
    private let contentView: UIView = {
        let cv = UIView()
//        cv.backgroundColor = .blue
        return cv
    } ()

    private let headerView = HeaderView(title: "Welcome", subTitle: "Home Page"/*, backgroundColor: .red*/)
    private let topMoviePicksText = HeaderView(title: "Top Movie Picks"/*, backgroundColor: .green*/)
    private let upComingMoviePicksText = HeaderView(title: "Up coming Movie Picks"/*, backgroundColor: .green*/)
    private let seeAllButtonWithTopMovie = CustomButton(title: "See all", fontSize: .small, titleColor: .darkText)
    private let seeAllButtonWithUpcomingMovie = CustomButton(title: "See all", fontSize: .small, titleColor: .darkText)
    private let logOutButton = CustomButton(title: "Log out", hasBackground: false, fontSize: .small, titleColor: .red)
    private let deleteAccountButton = CustomButton(title: "Delete Account", hasBackground: false, fontSize: .small, titleColor: .red)
    private let movieDetailsButton = CustomButton(title: "Movie Details", hasBackground: false, fontSize: .small, titleColor: .red)
    let movieListPlaceholderTopMovie = UIView()
    let movieListPlaceholderUpcomingMovie = UIView()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupMovieListViewController(to: topMoviePicksText)
        self.setupMovieListViewController(to: upComingMoviePicksText)
        self.seeAllButtonWithTopMovie.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        self.seeAllButtonWithUpcomingMovie.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        
        self.logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.deleteAccountButton.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
        self.movieDetailsButton.addTarget(self, action: #selector(didTapMovieDetails), for: .touchUpInside)
        
    }

    private func setUpUI(){
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor/*, constant: 10*/),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor/*, constant: -10*/),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor/*, constant: -20*/),
        ])
        
        self.contentView.addSubview(headerView)
        self.contentView.addSubview(topMoviePicksText)
        self.contentView.addSubview(upComingMoviePicksText)
        self.contentView.addSubview(seeAllButtonWithTopMovie)
        self.contentView.addSubview(seeAllButtonWithUpcomingMovie)
        self.contentView.addSubview(movieListPlaceholderTopMovie)
        self.contentView.addSubview(logOutButton)
        self.contentView.addSubview(deleteAccountButton)
        self.contentView.addSubview(movieDetailsButton)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        movieDetailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.pinToTheRightAndBottomOfSomething(height: 0.08, to: contentView, to: nil, to: nil, topPlace: true)
        topMoviePicksText.pinToTheRightAndBottomOfSomething(height: 0.05, to: contentView, to: nil, to: headerView)
        upComingMoviePicksText.pinToTheRightAndBottomOfSomething(height: 0.05, to: contentView, to: nil, to: movieListPlaceholderTopMovie)
        movieListPlaceholderTopMovie.pinToTheRightAndBottomOfSomething(height: 0.4, to: contentView)
        seeAllButtonWithTopMovie.pinButtonToBottomOfSomethingTrailing(to: contentView, to: topMoviePicksText)
        seeAllButtonWithUpcomingMovie.pinButtonToBottomOfSomethingTrailing(to: contentView, to: upComingMoviePicksText)
        
        
        
        NSLayoutConstraint.activate([
            
//            self.upComingMoviePicksText.topAnchor.constraint(equalTo: topMoviePicksText.bottomAnchor, constant: 750),
//            self.upComingMoviePicksText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            self.upComingMoviePicksText.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            self.upComingMoviePicksText.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            
            self.movieDetailsButton.bottomAnchor.constraint(equalTo: self.logOutButton.bottomAnchor, constant: -20),
            self.movieDetailsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.movieDetailsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.movieDetailsButton.heightAnchor.constraint(equalToConstant: 25),
            
            self.logOutButton.bottomAnchor.constraint(equalTo: self.deleteAccountButton.bottomAnchor, constant: -20),
            self.logOutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.logOutButton.heightAnchor.constraint(equalToConstant: 25),
            
//            self.deleteAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            self.deleteAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.deleteAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.deleteAccountButton.heightAnchor.constraint(equalToConstant: 25),
            
            self.deleteAccountButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
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
    
    @objc private func didTapMovieDetails() {
        let vc = MovieDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
