//
//  ArticleListViewController.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 23.10.2022.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    // MARK: - Private Properties
    private var collectionView: UICollectionView!
    
    private var viewModel: ArticleListViewModelProtocol! {
        didSet {
            viewModel.newsCategoryChanged = { [weak self] indexPaths in
                self?.removeActivityIndicator()
                self?.collectionView.reloadItems(at: indexPaths)
                self?.fetchNews()
            }
        }
    }
    
    private let articleCellIdentifier = "articleCell"
    private let newsCategoryCellIdentifier = "newsCategoryCell"
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        viewModel = ArticleListViewModel()
        
        collectionView.register(NewsCategoryCell.self, forCellWithReuseIdentifier: newsCategoryCellIdentifier)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: articleCellIdentifier)
        fetchNews()
    }
    
    // MARK: - Private Methods
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News"
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func fetchNews() {
        showActivityIndicator()
        collectionView.reloadSections(IndexSet(integer: 1))
        viewModel.fetchArticles { [weak self] in
            self?.removeActivityIndicator()
            self?.collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
    
}


// MARK: - UICollectionViewDataSource
extension ArticleListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.newsCategoriesCount()
        }
        return viewModel.articlesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section  == 0 {
            guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: newsCategoryCellIdentifier,
                    for: indexPath
                ) as? NewsCategoryCell
            else { return UICollectionViewCell() }
            cell.viewModel = viewModel.getNewsCategoryCellViewModel(at: indexPath)
            return cell
        }
        
        
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: articleCellIdentifier,
                for: indexPath
            ) as? ArticleCell
        else { return UICollectionViewCell() }
        
        cell.viewModel = viewModel.getArticleCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ArticleListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.setNewsCategory(by: indexPath)
        } else {
            let acViewController = ArticleContentViewController()
            let viewModel = viewModel.getArticleContenViewModel(at: indexPath)
            acViewController.viewModel = viewModel
            navigationController?.pushViewController(acViewController, animated: true)
        }
    }
    
}

// MARK: - UICollectionViewCompositionalLayout
extension ArticleListViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let provider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            
            if sectionIndex % 2 == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(44))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 5, leading: 20, bottom: 0, trailing: 20)
                section.orthogonalScrollingBehavior = .continuous
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
            }
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: provider)
    }
    
}

