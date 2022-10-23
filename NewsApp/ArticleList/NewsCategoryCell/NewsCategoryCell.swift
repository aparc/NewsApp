//
//  CollectionViewCell.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 23.10.2022.
//

import UIKit

class NewsCategoryCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    var viewModel: NewsCategoryCellViewModelProtocol! {
        didSet {
            configure()
        }
    }
    
    // MARK: - Private Properties
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let newsCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Private Methods
    private func configure() {
        newsCategoryLabel.text = viewModel.label
        newsCategoryLabel.textColor = viewModel.isSelected ? .white : .black
        
        icon.image = UIImage(systemName: viewModel.symbol)
        icon.tintColor = viewModel.isSelected ? .white : .black
        backgroundColor = viewModel.isSelected ? .black : .systemGray5
        layer.cornerRadius = 10
        contentView.addSubview(newsCategoryLabel)
        contentView.addSubview(icon)
        setupConstraints()
    }
    
    private func setupConstraints() {
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        icon.trailingAnchor.constraint(equalTo: newsCategoryLabel.leadingAnchor, constant: -8).isActive = true
        
        newsCategoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        newsCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
}
