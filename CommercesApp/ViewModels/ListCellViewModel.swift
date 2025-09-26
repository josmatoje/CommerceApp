//
//  ListCellViewModel.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 25/9/25.
//

import Foundation
import UIKit

final class ListCellViewModel {
    
    //MARK: parameters
    private let category: Category
    public let distance: String
    private let imageURL: String
    public let title: String
    public let adress: Address
    
    //MARK: init
    init(category: Category, distance: String, imageURL: String, title: String, adress: Address) {
        self.category = category
        self.distance = distance
        self.imageURL = imageURL
        self.title = title
        self.adress = adress
    }
    
    //MARK: functions
    public func categoryIcon() -> String {
        switch category {
        case .food:
            return "Catering_white"
        case .shopping:
            return "Cart_white"
        case .beauty:
            return "Car wash_white"
        case .leisure:
            return "Leisure_white"
        case .directSales:
            return "Payment_Regulated_Parking_white"
        case .electricStation:
            return "Electric Scooter_white"
        case .gasStation:
            return "EES_white"
        }
    }
    
    public func categoryColor() -> UIColor {
        switch category {
        case .beauty:
            return .systemOrange
        case .directSales:
            return .systemBlue
        case .electricStation:
            return .systemTeal
        case .food:
            return .systemPurple
        case .gasStation:
            return .systemRed
        case .leisure:
            return .systemYellow
        case .shopping:
            return .systemGreen
        }
    }
    public func categoryName() -> String {
        return category.rawValue
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageURL) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

