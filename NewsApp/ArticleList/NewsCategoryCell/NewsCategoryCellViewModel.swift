//
//  NewsCategoryCellViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

protocol NewsCategoryCellViewModelProtocol {
    var label: String { get }
    var symbol: String { get }
    var isSelected: Bool { get }
    init(newsCategory: NewsCategory, isSelected: Bool)
}

class NewsCategoryCellViewModel: NewsCategoryCellViewModelProtocol {
    var label: String
    var symbol: String
    var isSelected: Bool
    
    required init(newsCategory: NewsCategory, isSelected: Bool) {
        self.label = newsCategory.rawValue.capitalized
        self.symbol = newsCategory.symbol
        self.isSelected = isSelected
    }
}
