//
//  AtricleViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 13.08.2022.
//

import UIKit

class ArticleViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLaber: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Public Properties
    var article: Article!
    
	// MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
	// MARK: - Private Methods
    private func setupView() {
		fetchImage()
        authorLaber.text = article.author
        releaseDateLabel.text = article.date
        titleLabel.text = article.title
        contentLabel.text = article.content
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
