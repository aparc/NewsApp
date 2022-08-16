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
    
    init(articleData: [String: Any]) {
        author = articleData["author"] as? String ?? ""
        content = articleData["content"] as? String ?? ""
        date = articleData["date"] as? String ?? ""
        imageUrl = articleData["imageUrl"] as? String ?? ""
        readMoreUrl = articleData["readMoreUrl"] as? String ?? ""
        time = articleData["time"] as? String ?? ""
    }
    
    static func getArticles(from value: Data) -> [Article] {
        guard let articleData = value as? [String: Any] else { return [] }
        
        
    }
    
}

struct NewsResponse: Decodable {
    let category: NewsCategory
    let data: [Article]
    
    static func getNewsResponse(from value: Any) -> NewsResponse? {
        guard let responseData = value as? [String: Any] else { return nil }
        
        let category = NewsCategory(rawValue: responseData["category"])
        let articles = Article.get
        
        return nil
    }
    
}
