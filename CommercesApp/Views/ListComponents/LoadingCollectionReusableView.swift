//
//  LoadingCollectionReusableView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 30/9/25.
//

import UIKit

final class LoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "LoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    private func addConstrains() {
        
    }
}
