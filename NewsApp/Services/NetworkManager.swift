//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 12.08.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    
    case invalidURL
    case noData
    case decodingError
    
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch(url: String, completion: @escaping (Result<NewsResponse, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let newsResponse = NewsResponse.getNewsResponse(from: value)
                    completion(.success(newsResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
}
