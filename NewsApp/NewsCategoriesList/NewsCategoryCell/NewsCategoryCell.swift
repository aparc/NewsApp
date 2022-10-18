//
//  NewsCategoryCell.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 08.08.2022.
//

import UIKit

class NewsCategoryCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    var viewModel: NewsCategoryCellViewModelProtocol! {
        didSet {
            configure(with: viewModel.label)
        }
    }
    
    // MARK: - Private Properties
    private let newsCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 29)
        return label
    }()
    
    // MARK: - Private Methods
    private func configure(with title: String) {
        newsCategoryLabel.text = title
        backgroundColor = .systemGray
        layer.cornerRadius = 15
        addSubview(newsCategoryLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        newsCategoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        newsCategoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
}
