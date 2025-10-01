//
//  ListCellDataSource.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import Foundation
import UIKit

protocol ListCellDataSourceDelegate: AnyObject {
    func loadMoreCommerces(_ scrollView: UIScrollView)
}

final class ListCellDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public var commerces: [ListCellViewModel] = []
    
    public var delegate: ListCellDataSourceDelegate?
    
    public var filterCommercesCount: Int = 0
    
    override init (){ }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commerces.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCellView.cellIdentifier,
            for: indexPath
        ) as? ListCellView else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: commerces[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: LoadingCollectionReusableView.identifier,
                                                                     for: indexPath) as? LoadingCollectionReusableView
        else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard commerces.count > filterCommercesCount else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 32, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        commerces[indexPath.row].selectCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.loadMoreCommerces(scrollView)
    }
}
