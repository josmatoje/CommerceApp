//
//  ListCategoryView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 26/9/25.
//

import UIKit

final class ListCategoryView: UICollectionViewCell {
    //MARK: parameters
    public static let cellIdentifier: String = "ListCategoryView"
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    private let categoryName: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = .systemFont(ofSize: 14,
                                         weight: .medium)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()

    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(iconView, categoryName)
        addConstraints()
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 2)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            categoryName.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryName.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 4),
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
        categoryName.text = nil
        categoryName.textColor = nil
    }
    
    public func configure(with category: Category, isSelected: Bool){
        contentView.backgroundColor = isSelected ? category.color() : .systemBackground
        iconView.image = UIImage(named: isSelected ? category.whiteIcon() : category.colorIcon())
        categoryName.text = category.name()
        categoryName.textColor = isSelected ? .white : category.color()
    }
}
