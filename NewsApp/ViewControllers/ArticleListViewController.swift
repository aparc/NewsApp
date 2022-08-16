//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 13.08.2022.
//

import UIKit


class ArticleListViewController: UICollectionViewController {
	
	// MARK: - Public Properties
	var newsCategory: NewsCategory!
	
	// MARK: - Private Properties
	private var articleList = [Article]()
	
	// MARK: - Life Cycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		title = newsCategory.rawValue.capitalized
		showActivityIndicator()
		fetchNews(by: newsCategory)
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showArticle" {
			guard let articleVC = segue.destination as? ArticleViewController else { return }
			guard let article = sender as? Article else { return }
			
			articleVC.article = article
		}
	}
	
}

// MARK: - Networking
extension ArticleListViewController {
	
	private func fetchNews(by category: NewsCategory) {
		NetworkManager.shared.fetchArticles(
			url: "https://inshorts.deta.dev/news?category=\(newsCategory.rawValue)"
		) { [weak self] result in
			switch result {
			case .success(let articles):
                self?.articleList = articles
				self?.removeActivityIndicator()
				self?.collectionView.reloadData()
				
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
}

// MARK: - UICollectionViewDataSource
extension ArticleListViewController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		articleList.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell
		else {
			return UICollectionViewCell()
		}
		cell.configure(with: articleList[indexPath.item])
		return cell
	}
	
}

// MARK: - UICollectionViewDelegate
extension ArticleListViewController {
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showArticle", sender: articleList[indexPath.item])
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
