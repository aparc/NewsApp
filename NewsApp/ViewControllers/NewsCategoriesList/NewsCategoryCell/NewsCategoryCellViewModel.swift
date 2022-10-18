//
//  NewsCategoryCellViewModel.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 18.10.2022.
//

import Foundation

protocol NewsCategoryCellViewModelProtocol {
    var label: String { get }
    init(label: String)
}

class NewsCategoryCellViewModel: NewsCategoryCellViewModelProtocol {
    var label: String

    required init(label: String) {
        self.label = label
    }
}
