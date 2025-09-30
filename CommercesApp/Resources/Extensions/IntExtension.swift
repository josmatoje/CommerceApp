//
//  IntExtension.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import Foundation

extension Int {
    var whitDotsFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "es_ES")
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
