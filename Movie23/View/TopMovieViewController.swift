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
        return scrollView
    } ()
    
    private let stackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 200) // Adjust height as needed
        ])
        
        scrollView.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackview.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func addPosterViews() {
        // Example data
        let movieTitles = ["Movie 1", "Movie 2", "Movie 3", "Movie 4", "Movie 5"]
        let movieSubtitles = ["Subtitle 1", "Subtitle 2", "Subtitle 3", "Subtitle 4", "Subtitle 5"]
        
        // Create and add poster views to the stack view
        for (index, title) in movieTitles.enumerated() {
            let posterView = MoviePosterView(title: title, subTitle: movieSubtitles[index])
            stackview.addArrangedSubview(posterView)
            
            // Set the width of each poster view
            posterView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                posterView.widthAnchor.constraint(equalToConstant: 100) // Adjust width as needed
            ])
        }
    }
    
}
