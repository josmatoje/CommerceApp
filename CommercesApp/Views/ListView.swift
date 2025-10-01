//
//  ListView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import UIKit

protocol ListViewDelegate: AnyObject {
    func listView(
        _ listView: ListView,
        didSelectCommerce commerce: Commerce
    )
}

final class ListView: UIView {

    // MARK: propierties
    public weak var delegate: ListViewDelegate?
    
    private let viewModel = ListViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    private var countView: BannerView =  {
        let countView = BannerView(frame: .zero)
        countView.translatesAutoresizingMaskIntoConstraints = false
        return countView
    } ()
    
    
    private var distanceView: BannerView = {
        let distanceView = BannerView(frame: .zero)
        distanceView.translatesAutoresizingMaskIntoConstraints = false
        return distanceView
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
        categoriesView.showsHorizontalScrollIndicator = false
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
        collectionView.register(ListCellView.self,
                                forCellWithReuseIdentifier: ListCellView.cellIdentifier)
        collectionView.backgroundColor = .secondarySystemBackground
        
        collectionView.register(LoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: LoadingCollectionReusableView.identifier)
        return collectionView
    } ()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        viewModel.delegate = self
        viewModel.categoryDataSource.delegate = self
        viewModel.commerceDataSource.delegate = viewModel
        viewModel.fetchCommerces()
        addSubviews(spinner, countView, distanceView, categoriesView, collectionView)
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
            
            countView.heightAnchor.constraint(equalToConstant: 100),
            countView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2 - 24),
            countView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            countView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            distanceView.heightAnchor.constraint(equalToConstant: 100),
            distanceView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2 - 24),
            distanceView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            distanceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            categoriesView.heightAnchor.constraint(equalToConstant: 72),
            categoriesView.topAnchor.constraint(equalTo: countView.bottomAnchor, constant: 16),
            categoriesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),

            collectionView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setUpCollectionView() {
        categoriesView.dataSource = viewModel.categoryDataSource
        categoriesView.delegate = viewModel.categoryDataSource
        
        collectionView.dataSource = viewModel.commerceDataSource
        collectionView.delegate = viewModel.commerceDataSource
    }
}

extension ListView: ListViewModelDelegate {
    func didLoadTotalCommerce() {
        viewModel.commerceDataSource.commerces.forEach { $0.delegate = self }
        
        countView.configure(
            with: UIColor(named: "ContentColor") ?? .secondarySystemBackground,
            number: viewModel.filterCommercesCount,
            numberColor: .white,
            descriptionText: "Comercios",
            descriptionColor: .white)
        
        distanceView.configure(
            with: .systemBackground,
            number: 10,
            numberColor: .systemOrange,
            descriptionText: "A menos de x km",
            descriptionColor: .systemGray2
        )
        
        spinner.stopAnimating()
        
        countView.isHidden = false
        distanceView.isHidden = false
        categoriesView.isHidden = false
        collectionView.isHidden = false
        
        categoriesView.reloadData()
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.countView.alpha = 1
            self.distanceView.alpha = 1
            self.categoriesView.alpha = 1
            self.collectionView.alpha = 1
        }
    }
    
    func updateView() {
        viewModel.setCellViewModels(delegate: self)
        collectionView.reloadData()
    }
}
extension ListView: ListCellViewModelDelegate {
    func didSelectCommerce(_ commerceId: Int) {
        if let commerce = viewModel.getCommerce(for: commerceId) {
            delegate?.listView(self, didSelectCommerce: commerce)
        }
    }
}

extension ListView: CategoryDataSourceDelegate {
    
    func categorySelected(_ category: Category?) {
        viewModel.resetComerceList()
        viewModel.loadInitialCommerces()
    }
    
}
