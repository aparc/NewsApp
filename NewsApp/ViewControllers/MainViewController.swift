//
//  MainViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 08.08.2022.
//

import UIKit

enum NewsCategory: String, CaseIterable, Decodable {
    
    case business
    case sport
    case world
    case politics
    case technology
    case science
    case automobile
    
}

class MainViewController: UICollectionViewController {
    
    let newsCategories = NewsCategory.allCases
    
    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension MainViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "newsCategoryCell", for: indexPath) as? NewsCategoryCell
        else {
            return UICollectionViewCell()
        }
        
        cell.newsCategoryLabel.text = newsCategories[indexPath.item].rawValue.capitalized
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension MainViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchNews(by: newsCategories[indexPath.item])
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 80)
    }
    
}

// MARK: - Networking
extension MainViewController {
    private func fetchNews(by category: NewsCategory) {
        guard
            let url = URL(string: "https://inshorts.deta.dev/news?category=\(category.rawValue)")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let news = try JSONDecoder().decode(NewsResponse.self, from: data)
                print(news)
                self?.successAlert()
            } catch let error {
                self?.failedAlert()
                print(error)
            }
        }.resume()
    }
}
