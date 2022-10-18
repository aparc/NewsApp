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
    var image: Data? { get }
    init(article: Article)
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
    
    var image: Data? {
        NetworkManager.shared.fetchImageData(url: article.imageUrl)
    }
    
    private let article: Article
    
    required init(article: Article) {
        self.article = article
    }
}
