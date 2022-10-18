//
//  NewsCategoriesListViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

enum NewsCategory: String, CaseIterable {
    
    case business
    case sport
    case world
    case politics
    case technology
    case science
    case automobile
    
}

protocol NewsCategoriesListViewModelProtocol {
    func numberOfRows() -> Int
    func getNewsCategories() -> [NewsCategory]
    func getNewsCategoryCellViewModel(at indexPath: IndexPath) -> NewsCategoryCellViewModelProtocol
    func getArticleListViewModel(at indexPath: IndexPath) -> ArticleListViewModelProtocol
}

class NewsCategoriesListViewModel: NewsCategoriesListViewModelProtocol {
    
    func numberOfRows() -> Int {
        NewsCategory.allCases.count
    }
    
    func getNewsCategories() -> [NewsCategory] {
        NewsCategory.allCases
    }
    
    func getNewsCategoryCellViewModel(at indexPath: IndexPath) -> NewsCategoryCellViewModelProtocol {
        let label = NewsCategory.allCases[indexPath.item].rawValue.capitalized
        return NewsCategoryCellViewModel(label: label)
    }
    
    func getArticleListViewModel(at indexPath: IndexPath) -> ArticleListViewModelProtocol {
        ArticleListViewModel(newsCategory: getNewsCategories()[indexPath.item])
    }
    
}
