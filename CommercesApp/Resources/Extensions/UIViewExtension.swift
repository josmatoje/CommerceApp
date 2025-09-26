//
//  UIViewExtension.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }
}
