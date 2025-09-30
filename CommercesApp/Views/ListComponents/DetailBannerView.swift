//
//  DetailBannerView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 30/9/25.
//

import UIKit

final class DetailBannerView: UIView {
    
    private let descriptionText: UILabel = {
        let descriptionText = UILabel()
        descriptionText.font = .systemFont(ofSize: 12, weight: .medium)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        return descriptionText
    }()

    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubviews(descriptionText)
        addConstraints()
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            descriptionText.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        ])
    }
    
    public func configure(with backgroundColor: UIColor, descriptionText: String) {
        self.backgroundColor = backgroundColor
        
        self.descriptionText.text = descriptionText
    }


}
