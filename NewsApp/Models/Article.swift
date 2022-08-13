//
//  Article.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 08.08.2022.
//


struct Article: Decodable, CustomStringConvertible {
    let author: String
    let content: String
    let date: String
    let imageUrl: String
    let title: String
    
    var description: String {
        title
    }
}

struct NewsResponse: Decodable {
    let category: NewsCategory
    let data: [Article]
}
