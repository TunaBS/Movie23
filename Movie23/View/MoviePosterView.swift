//
//  MoviePosterView.swift
//  Movie23
//
//  Created by BS00880 on 25/6/24.
//

import UIKit

class MoviePosterView: UIView {
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "background_dummy_img")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()

    // MARK: - LifeCycle
    init(/*image: UIImage?,*/ title: String, subTitle: String) {
        super.init(frame: .zero)
//        self.imageView.image = image
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.imageView.widthAnchor.constraint(equalToConstant: 90),
            self.imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 2),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
