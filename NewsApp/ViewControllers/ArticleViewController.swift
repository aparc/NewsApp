//
//  AtricleViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 13.08.2022.
//

import UIKit

class ArticleViewController: UIViewController {
    
    // MARK: - Private Properties
    private var article: Article
    
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
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        fetchImage()
        authorLaber.text = article.author
        releaseDateLabel.text = article.date
        titleLabel.text = article.title
        contentLabel.text = article.content
        
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

// MARK: - Networking
extension ArticleViewController {
    
    private func fetchImage() {
        NetworkManager.shared.fetchData(from: article.imageUrl) { [weak self] result in
            switch result {
            case .success(let data):
                self?.imageView.image = UIImage(data: data)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
