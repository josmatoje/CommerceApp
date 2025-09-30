//
//  CategoryDataSource.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import Foundation
import UIKit


protocol CategoryDataSourceDelegate: AnyObject {
    func categorySelected(_ category: Category?)
}

final class CategoryDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate : CategoryDataSourceDelegate?
    var categories: [Category] = []
    var selectedCategory: Category?
    
    init (_ categories: [Category]){
        self.categories = categories
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCategoryView.cellIdentifier,
            for: indexPath
        ) as? ListCategoryView else {
            fatalError("Unsupported cell")
        }
        let category = categories[indexPath.row]
        cell.configure(with: category, isSelected: selectedCategory == category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = selectedCategory == categories[indexPath.row] ? nil : categories[indexPath.row]
        delegate?.categorySelected(selectedCategory)
    }
}
