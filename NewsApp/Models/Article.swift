//
//  Article.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 08.08.2022.
//

struct Article: CustomStringConvertible {
    let author: String
    let content: String
    let date: String
    let imageUrl: String
    let title: String
    
    var description: String {
        title
    }
    
    init(author: String, content: String, date: String, imageUrl: String, title: String) {
        self.author = author
        self.content = content
        self.date = date
        self.imageUrl = imageUrl
        self.title = title
    }
    
    init(articleData: [String: Any]) {
        author = articleData["author"] as? String ?? ""
        content = articleData["content"] as? String ?? ""
        date = articleData["date"] as? String ?? ""
        imageUrl = articleData["imageUrl"] as? String ?? ""
        title = articleData["title"] as? String ?? ""
    }
    
    static func getArticles(from value: Any) -> [Article] {
        guard let data = value as? [String: Any] else { return [] }
        guard let articleData = data["data"] as? [[String: Any]] else { return [] }
        
        return articleData.map { Article(articleData: $0) }
    }
    
}

