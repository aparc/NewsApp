//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

protocol ArticleListViewModelProtocol {
    var title: String { get }
    init(newsCategory: NewsCategory)
    func fetchArticles(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func getArticleCellViewModel(at indexPath: IndexPath) -> ArticleCellViewModelProtocol
    func getArticleContenViewModel(at indexPath: IndexPath) -> ArticleContentViewModelProtocol
}

class ArticleListViewModel: ArticleListViewModelProtocol {

    var title: String {
        newsCategory.rawValue.capitalized
    }
    
    private var newsCategory: NewsCategory
    private var articles: [Article] = []
    
    required init(newsCategory: NewsCategory) {
        self.newsCategory = newsCategory
    }

    func numberOfRows() -> Int {
        articles.count
    }
    
    func getArticleContenViewModel(at indexPath: IndexPath) -> ArticleContentViewModelProtocol {
        ArticleContentViewModel(article: articles[indexPath.item])
    }
    
    func getArticleCellViewModel(at indexPath: IndexPath) -> ArticleCellViewModelProtocol {
        ArticleCellViewModel(article: articles[indexPath.item])
    }
    
    func fetchArticles(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchArticles(
            url: "https://inshorts.deta.dev/news?category=\(newsCategory.rawValue)"
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.articles = data
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
