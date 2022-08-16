//
//  NewsCell.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 12.08.2022.
//

import UIKit

class ArticleCell: UICollectionViewCell {
	
	// MARK: - IB Outlets
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	// MARK: - Public Methods
	func configure(with article: Article) {
		authorLabel.text = article.author
		contentLabel.text = article.title
		fetchImage(from: article.imageUrl)
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




