//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 13.08.2022.
//

import UIKit


class ArticleListViewController: UICollectionViewController {
	
	// MARK: - Public Properties
    var viewModel: ArticleListViewModelProtocol! {
        didSet {
            title = viewModel.title
            viewModel.fetchArticles { [weak self] in
                self?.removeActivityIndicator()
                self?.collectionView.reloadData()
            }
        }
    }
	
	// MARK: - Private Properties
    private let cellIdentifier = "articleCell"
	
	// MARK: - Life Cycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .secondarySystemBackground
		showActivityIndicator()
	}
	
}

// MARK: - UICollectionViewDataSource
extension ArticleListViewController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ArticleCell
		else {
			return UICollectionViewCell()
		}
        cell.viewModel = viewModel.getArticleCellViewModel(at: indexPath)
		return cell
	}
	
}

// MARK: - UICollectionViewDelegate
extension ArticleListViewController {
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let acViewModel = viewModel.getArticleContenViewModel(at: indexPath)
        let acViewController = ArticleContentViewController()
        acViewController.viewModel = acViewModel
        navigationController?.pushViewController(acViewController, animated: true)
	}
	
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ArticleListViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIScreen.main.bounds.width - 48, height: 150)
	}
	
}
