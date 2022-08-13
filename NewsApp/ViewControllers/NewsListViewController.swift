//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 13.08.2022.
//

import UIKit


class NewsListViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    var newsCategory: NewsCategory!
    
    // MARK: - Private Properties
    private var newsList = [Article]()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newsCategory.rawValue.capitalized
        fetchNews(by: newsCategory)
    }
    
    // MARK: - Private Methods
    private func fetchNews(by category: NewsCategory) {
        NetworkManager.shared.fetch(
            NewsResponse.self,
            url: "https://inshorts.deta.dev/news?category=\(newsCategory.rawValue)"
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.newsList = response.data
                self?.collectionView.reloadData()
                print(response.data.first?.content ?? ""
                )
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            guard let articleVC = segue.destination as? ArticleViewController else { return }
            guard let article = sender as? Article else { return }
        
            articleVC.article = article
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: newsList[indexPath.item])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showArticle", sender: newsList[indexPath.item])
    }
    
    
}

extension NewsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 150)
    }
    
}
