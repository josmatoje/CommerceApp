//
//  ListCellDataSource.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import Foundation
import UIKit

final class ListCellDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public var commerces: [ListCellViewModel]
    
    init (_ commerces: [ListCellViewModel] = []){
        self.commerces = commerces
    }
    
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
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionHeader else {
//            fatalError("Unsupported")
//        }
//        
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                     withReuseIdentifier: LoadingCollectionReusableView.identifier,
//                                                                     for: indexPath)
//        return footer
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        
//        return CGSize(width: collectionView.frame.width, height: 60)
//    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 32, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        commerces[indexPath.row].selectCell()
    }
}
