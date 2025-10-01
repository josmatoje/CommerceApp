//
//  ListCellView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 25/9/25.
//

import UIKit

class ListCellView: UICollectionViewCell {
    //MARK: parameters
    public static let cellIdentifier: String = "ListCellView"
    
    private let topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = .orange
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.layer.cornerRadius = 8
        topView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return topView
    }()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    private let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.textColor = .white
        distanceLabel.font = .systemFont(ofSize: 18,
                                     weight: .medium)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        return distanceLabel
    }()
    
    private let rightArrow: UIImageView = {
        let rightArrow = UIImageView(image: UIImage(systemName: "chevron.right"))
        rightArrow.contentMode = .scaleAspectFit
        rightArrow.clipsToBounds = true
        rightArrow.tintColor = .white
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        return rightArrow
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = .systemFont(ofSize: 14,
                                     weight: .medium)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .label
        descriptionLabel.font = .systemFont(ofSize: 12,
                                     weight: .light)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(topView, iconView, distanceLabel, rightArrow, imageView, titleLabel, descriptionLabel)
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
            
            topView.heightAnchor.constraint(equalToConstant: 48),
            
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            distanceLabel.topAnchor.constraint(equalTo:  topAnchor, constant: 18),
            distanceLabel.trailingAnchor.constraint(equalTo: rightArrow.trailingAnchor, constant: -16),
            
            rightArrow.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rightArrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightArrow.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
        distanceLabel.text = nil
        imageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    public func configure(with viewModel: ListCellViewModel){
        topView.backgroundColor = viewModel.category.color()
        iconView.image = UIImage(named: viewModel.category.whiteIcon())
        distanceLabel.text = viewModel.distance
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.addressFormated()
        
        viewModel.fetchImage { [weak self] result in //weak for no memory leaks from the cells by the image
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        let image = UIImage(data: image)
                        self?.imageView.image = image
                    }
                case .failure:
                    print("Error fetching image")
                    DispatchQueue.main.async {
                        let image: UIImage? = UIImage(named: "only_image")
//                        let image: UIImage? = UIImage(named: "placeholder")
                        self?.imageView.image = image
                    }
                    break
                }
        }
    }
}
