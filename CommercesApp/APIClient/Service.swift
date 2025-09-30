//
//  Service.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import Foundation

final class Service {
    static let shared = Service()
    
    private let baseUrl = "https://waylet-web-export.s3.eu-west-1.amazonaws.com/commerces.json"
    
    enum ServiceError: Error {
        case invalidRequest
        case invalidData
    }
    private init() {}
    
    public func execute(completion: @escaping (Result<[Commerce], Error>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(ServiceError.invalidRequest))
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? ServiceError.invalidData))
                return
            }
            do {
                let result = try JSONDecoder().decode([Commerce].self, from: data)
                completion(.success(result))
//                let filterResult = result.filter{
//                    $0.photo != ""
//                }
//                completion(.success(filterResult))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
