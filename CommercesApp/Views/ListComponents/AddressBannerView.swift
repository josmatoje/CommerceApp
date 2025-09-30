//
//  AddressBannerView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 30/9/25.
//

import UIKit

final class AddressBannerView: UIView {
    
    private let imageLoader: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder")) //TODO: search another image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let streetText: UILabel = {
        let streetText = UILabel()
        streetText.font = .monospacedDigitSystemFont(ofSize: 14, weight: .semibold)
        streetText.translatesAutoresizingMaskIntoConstraints = false
        return streetText
    }()
    
    private let cityText: UILabel = {
        let cityText = UILabel()
        cityText.font = .systemFont(ofSize: 12, weight: .medium)
        cityText.translatesAutoresizingMaskIntoConstraints = false
        return cityText
    }()
    
    private let countryText: UILabel = {
        let countryText = UILabel()
        countryText.font = .systemFont(ofSize: 10, weight: .light)
        countryText.translatesAutoresizingMaskIntoConstraints = false
        return countryText
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubviews(imageLoader, streetText, cityText, countryText)
        addConstraints()
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            imageLoader.heightAnchor.constraint(equalToConstant: 32),
            imageLoader.widthAnchor.constraint(equalToConstant: 32),
            imageLoader.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageLoader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            streetText.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            streetText.leadingAnchor.constraint(equalTo: imageLoader.trailingAnchor, constant: 16),
            
            cityText.topAnchor.constraint(equalTo: streetText.bottomAnchor, constant: 8),
            cityText.leadingAnchor.constraint(equalTo: imageLoader.trailingAnchor, constant: 16),
            
            countryText.topAnchor.constraint(equalTo: cityText.bottomAnchor, constant: 8),
            countryText.leadingAnchor.constraint(equalTo: imageLoader.trailingAnchor, constant: 16),
            countryText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ])
    }
    
    public func configure(with backgroundColor: UIColor, streetText: String, cityText: String, countryText: String) {
        self.backgroundColor = backgroundColor
        
        self.streetText.text = streetText
        self.cityText.text = cityText
        self.countryText.text = countryText
    }

}
