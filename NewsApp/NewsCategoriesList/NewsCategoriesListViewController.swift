//
//  MainViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 08.08.2022.
//

import UIKit

class NewsCategoriesListViewController: UICollectionViewController {
    
	// MARK: - Private Properties
    private let cellIdentifier = "newsCategoryCell"
    private var viewModel: NewsCategoriesListViewModelProtocol! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsCategoriesListViewModel()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News"
        
        collectionView.register(NewsCategoryCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

// MARK: - UICollectionViewDataSource
extension NewsCategoriesListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NewsCategoryCell
        else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel.getNewsCategoryCellViewModel(at: indexPath)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension NewsCategoriesListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alViewController = ArticleListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        alViewController.viewModel = viewModel.getArticleListViewModel(at: indexPath)
        navigationController?.pushViewController(alViewController, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsCategoriesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 80)
    }
    
}
