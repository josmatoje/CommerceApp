//
//  ListView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import UIKit

final class ListView: UIView {

    // MARK:
    private let viewModel = ListViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    private let categoriesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let categoriesView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoriesView.isHidden = true
        categoriesView.alpha = 0
        categoriesView.translatesAutoresizingMaskIntoConstraints = false
        categoriesView.register(ListCategoryView.self, forCellWithReuseIdentifier: ListCategoryView.cellIdentifier)
        categoriesView.backgroundColor = .secondarySystemBackground
        return categoriesView
    } ()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCellView.self, forCellWithReuseIdentifier: ListCellView.cellIdentifier)
        collectionView.backgroundColor = .secondarySystemBackground
        return collectionView
    } ()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        viewModel.delegate = self
        viewModel.fetchCommerces()
        addSubviews(categoriesView, collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    // MARK: functions
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            categoriesView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            categoriesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32),
            
            collectionView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        categoriesView.dataSource = viewModel
        categoriesView.delegate = viewModel
        
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
}

extension ListView: ListViewModelDelegate {
    func didLoadTotalCommerce() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        }
    }
}
