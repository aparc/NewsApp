//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 12.08.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchArticles(url: String, completion: @escaping (Result<[Article], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let articles = Article.getArticles(from: value)
                    completion(.success(articles))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
