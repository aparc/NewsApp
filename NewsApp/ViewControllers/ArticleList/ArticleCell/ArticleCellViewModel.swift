//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

protocol ArticleCellViewModelProtocol {
    var author: String { get }
    var title: String { get }
    var image: Data? { get }
    var imageDidChange: ((ArticleCellViewModelProtocol) -> Void)? { get set }
    init(article: Article)
    func fetchImage()
}

class ArticleCellViewModel: ArticleCellViewModelProtocol {
    
    var author: String {
        article.author
    }
    
    var title: String {
        article.title
    }
    
    var image: Data?
    
    var imageDidChange: ((ArticleCellViewModelProtocol) -> Void)?
    
    private let article: Article
    
    required init(article: Article) {
        self.article = article
    }
    
    func fetchImage() {
        NetworkManager.shared.fetchData(from: article.imageUrl) { [unowned self] result in
            switch result {
            case .success(let data):
                self.image = data
                self.imageDidChange?(self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
