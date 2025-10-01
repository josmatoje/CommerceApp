//
//  LoadingCollectionReusableView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 30/9/25.
//

import UIKit

final class LoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "LoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubviews(spinner)
        addConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
