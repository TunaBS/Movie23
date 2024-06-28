//
//  TopMovieViewController.swift
//  Movie23
//
//  Created by BS00880 on 25/6/24.
//

import UIKit

class TopMovieViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.backgroundColor = .blue         //use color for testing
        return scrollView
    } ()
    
    private let stackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.backgroundColor = .red          //use color for testing
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.addPosterViews()
    }
    
    private func setUpUI() {
//        self.view.backgroundColor = .yellow         //use color for testing
        
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
        
        scrollView.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            stackview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -5),
            stackview.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func addPosterViews() {
        let movieTitles = ["Movie 1", "Movie 2", "Movie 3", "Movie 4", "Movie 5"]
        let movieSubtitles = ["Subtitle 1", "Subtitle 2", "Subtitle 3", "Subtitle 4", "Subtitle 5"]
        
        for (index, title) in movieTitles.enumerated() {
            let posterView = MoviePosterView(title: title, subTitle: movieSubtitles[index])
            stackview.addArrangedSubview(posterView)
            posterView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                posterView.widthAnchor.constraint(equalToConstant: 100) 
            ])
        }
    }
    
}
