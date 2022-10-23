//
//  NewsCell.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 12.08.2022.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    var viewModel: ArticleCellViewModelProtocol! {
        didSet {
            viewModel.imageDidChange = { [weak self] viewModel in
                self?.imageView.image = UIImage(data: viewModel.image ?? Data())
            }
            setupUI()
        }
    }
    
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
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    // MARK: - Private Methods
    func setupUI() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(imageView)
        layer.cornerRadius = 10
        backgroundColor = .white
        setupConstraints()
        
        authorLabel.text = viewModel.author
        contentLabel.text = viewModel.title
        viewModel.fetchImage()
    }
    
    private func setupConstraints() {
        // author label constraints
        authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -8).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        
        // content label constraints
        contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        
        // image view constraints
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
    
}
