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
    private let cellIdentifier = "newsCategoryCell"
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News"
        
        collectionView.register(NewsCategoryCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

// MARK: - UICollectionViewDataSource
extension MainViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsCategoryCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: newsCategories[indexPath.item].rawValue.capitalized)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension MainViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alViewController = ArticleListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let newsCategory = newsCategories[indexPath.item]
        alViewController.newsCategory = newsCategory
        navigationController?.pushViewController(alViewController, animated: true)
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
