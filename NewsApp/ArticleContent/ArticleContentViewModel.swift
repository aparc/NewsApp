//
//  ArticleContentViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

protocol ArticleContentViewModelProtocol {
    var author: String { get }
    var releaseDate: String { get }
    var title: String { get }
    var content: String { get }
    init(article: Article)
    func downloadImage(completion: @escaping (Data) -> Void)
}

class ArticleContentViewModel: ArticleContentViewModelProtocol {
    
    var author: String {
        article.author
    }
    
    var releaseDate: String {
        article.date
    }
    
    var title: String {
        article.title
    }
    
    var content: String {
        article.content
    }
    
    private let article: Article
    
    required init(article: Article) {
        self.article = article
    }
    
    func downloadImage(completion: @escaping (Data) -> Void) {
        NetworkManager.shared.fetchData(from: article.imageUrl) { result in
            switch result {
            case .success(let data): completion(data)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
