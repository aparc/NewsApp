//
//  MainViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 08.08.2022.
//

import UIKit

enum NewsCategory: String, CaseIterable {
    
    case business
    case sport
    case world
    case politics
    case technology
    case science
    case automobile
    
}

class MainViewController: UICollectionViewController {
    
	// MARK: - Private Properties
    private let newsCategories = NewsCategory.allCases
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleList" {
            guard let newsListVC = segue.destination as? ArticleListViewController else { return }
            guard let category = sender as? NewsCategory else { return }
        
            newsListVC.newsCategory = category
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
        performSegue(withIdentifier: "showArticleList", sender: newsCategories[indexPath.item])
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
