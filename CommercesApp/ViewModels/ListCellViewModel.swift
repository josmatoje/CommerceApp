//
//  ListCellViewModel.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 25/9/25.
//

import Foundation
import UIKit

protocol ListCellViewModelDelegate: AnyObject {
    func didSelectCommerce(_ commerceId: Int)
}

final class ListCellViewModel {
    
    //MARK: parameters

    public weak var delegate: ListCellViewModelDelegate?
    
    private let id: Int
    public let category: Category
    public let distance: String
    private let imageURL: String
    public let title: String
    public let address: Address
    
    
    //MARK: init
    init(id: Int, category: Category, distance: String, imageURL: String, title: String, address: Address) {
        self.id = id
        self.category = category
        self.distance = distance
        self.imageURL = imageURL
        self.title = title
        self.address = address
    }
    
    //MARK: functions
    public func addressFormated() -> String {
        if let street = address.street,
           let city = address.city,
           let state = address.state,
           let zip = address.zip,
           let country = address.country
           {
            return "\(street)\n\(zip) - \(city), \(state)\n\(country.uppercased())"
        } else {
            return "Dirección desconocida" //TODO: Localized
        }
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
    
    public func selectCell() {
        DispatchQueue.main.async {
            self.delegate?.didSelectCommerce(self.id)
        }
    }
}

