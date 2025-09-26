//
//  Commerce.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import Foundation

struct Commerce: Codable {
    let photo: String?
    let name: String?
    let category: Category?
    let cashback: Double?
    let location: [Double]?
    let openingHours: String?
    let address: Address?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case photo, name, category, cashback, location, openingHours, address
        case id = "_id"
    }
}
