//
//  NewsCell.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 12.08.2022.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    // MARK: - Public Methods
    func configure(with article: Article) {
        self.addSubview(authorLabel)
        self.addSubview(contentLabel)
        self.addSubview(imageView)
        layer.cornerRadius = 10
        backgroundColor = .white
        
        authorLabel.text = article.author
        contentLabel.text = article.title
        fetchImage(from: article.imageUrl)
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        // author label constraints
        authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -8).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        
        // content label constraints
        contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        
        // image view constraints
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    
}

// MARK: - Networking
extension ArticleCell {
    
    private func fetchImage(from imageUrl: String) {
        NetworkManager.shared.fetchData(from: imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}




