//
//  AtricleViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 13.08.2022.
//

import UIKit

class ArticleContentViewController: UIViewController {
    
    // MARK: - Public Properties
    var viewModel: ArticleContentViewModelProtocol! {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - Private Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let authorLaber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        authorLaber.text = viewModel.author
        releaseDateLabel.text = viewModel.releaseDate
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
        imageView.image = UIImage(data: viewModel.image ?? Data())
        
        view.addSubview(imageView)
        view.addSubview(authorLaber)
        view.addSubview(releaseDateLabel)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // image view constraints
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        // author label constraints
        authorLaber.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        authorLaber.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16).isActive = true
        authorLaber.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        authorLaber.trailingAnchor.constraint(greaterThanOrEqualTo: releaseDateLabel.leadingAnchor).isActive = true
        
        // release date label constraints
        releaseDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        releaseDateLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
        
        // title label constraints
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -16).isActive = true
        
        // content label constraints
        contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
    }
    
}

