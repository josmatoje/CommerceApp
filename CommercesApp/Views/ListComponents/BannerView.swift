//
//  BannerView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import UIKit

final class BannerView: UIView {
    
    private let numberLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = .monospacedDigitSystemFont(ofSize: 32, weight: .medium)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = .systemFont(ofSize: 14, weight: .medium)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubviews(numberLabel, descriptionLabel)
        addConstraints()
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
        ])
    }
    
    public func configure(with backgroundColor: UIColor, number: Int, numberColor: UIColor, descriptionText: String, descriptionColor: UIColor) {
        self.backgroundColor = backgroundColor
        numberLabel.text = number.whitDotsFormat
        numberLabel.textColor = numberColor
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = descriptionColor
    }
    
}
