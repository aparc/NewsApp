//
//  NewsCell.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 12.08.2022.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with article: Article) {
        authorLabel.text = article.author
        contentLabel.text = article.title
        
        NetworkManager.shared.fetchImage(from: article.imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
