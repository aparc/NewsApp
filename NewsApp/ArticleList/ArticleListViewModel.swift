//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

protocol ArticleListViewModelProtocol {
    var title: String { get }
    var articleListDidChanged: (() -> Void)? { get set }
    var newsCategoryChanged: (([IndexPath]) -> Void)? { get set }
    
    func fetchArticles(completion: @escaping () -> Void)
    func articlesCount() -> Int
    func newsCategoriesCount() -> Int
    func setNewsCategory(by indexPath: IndexPath)
    
    func getNewsCategoryCellViewModel(at indexPath: IndexPath) -> NewsCategoryCellViewModelProtocol
    func getArticleCellViewModel(at indexPath: IndexPath) -> ArticleCellViewModelProtocol
    func getArticleContenViewModel(at indexPath: IndexPath) -> ArticleContentViewModelProtocol
}

class ArticleListViewModel: ArticleListViewModelProtocol {

    var title: String {
        selectedCategory.rawValue.capitalized
    }
    
    var articleListDidChanged: (() -> Void)?
    var newsCategoryChanged: (([IndexPath]) -> Void)?
    
    private var selectedCategory = NewsCategory.business
    private var articles: [Article] = []
    
    func articlesCount() -> Int {
        articles.count
    }
    
    func newsCategoriesCount() -> Int {
        NewsCategory.allCases.count
    }
    
    func fetchArticles(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchArticles(
            url: "https://inshorts.deta.dev/news?category=\(selectedCategory.rawValue)"
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.articles = data
                self?.articleListDidChanged?()
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func setNewsCategory(by indexPath: IndexPath) {
        let oldCategory = selectedCategory
        let oldCategoryIndexPath = IndexPath(
            item: NewsCategory.allCases.firstIndex(of: oldCategory) ?? 0,
            section: 0
        )
        if oldCategoryIndexPath == indexPath {
            return
        }
        
        selectedCategory = NewsCategory.allCases[indexPath.row]
        newsCategoryChanged?([indexPath, oldCategoryIndexPath])
        removeArticleList()
    }
    
    func getArticleContenViewModel(at indexPath: IndexPath) -> ArticleContentViewModelProtocol {
        ArticleContentViewModel(article: articles[indexPath.item])
    }
    
    func getArticleCellViewModel(at indexPath: IndexPath) -> ArticleCellViewModelProtocol {
        ArticleCellViewModel(article: articles[indexPath.item])
    }
    
    func getNewsCategoryCellViewModel(at indexPath: IndexPath) -> NewsCategoryCellViewModelProtocol {
        let category = NewsCategory.allCases[indexPath.item]
        return NewsCategoryCellViewModel(
            newsCategory: category,
            isSelected: category == selectedCategory
        )
    }
    
    private func removeArticleList() {
        articles = []
        articleListDidChanged?()
    }
    
}
