//
//  DetailViewModel.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import Foundation
import CoreLocation
import MapKit

final class DetailViewModel {
    private let commerce: Commerce
    
    init(commerce: Commerce) {
        self.commerce = commerce
    }
    
    //MARK: functions
    public func title() -> String {
        commerce.name ?? "Commerce"
    }
    
    public func category() -> Category {
        commerce.category ?? .gasStation
    }
    
    public func cashBack() -> Double {
        commerce.cashback ?? 0
    }
    
    public func location() -> CLLocationCoordinate2D {
        if let location = commerce.location {
            CLLocationCoordinate2D(latitude: location[1], longitude: location[0])
        } else {
            CLLocationCoordinate2D()
        }
    }
    
    public func openingHours() -> String {
        commerce.openingHours ?? "Horario desconocido" //TODO: Localized
    }
    
    public func addressStreet() -> String {
        if let address = commerce.address,
           let street = address.street
           {
            return "\(street)"
        } else {
            return "Dirección desconocida" //TODO: Localized
        }
    }
    
    public func addressCity() -> String {
        if let address = commerce.address,
           let city = address.city,
           let state = address.state,
           let zip = address.zip
           {
            return "\(zip) - \(city), \(state))"
        } else {
            return "Dirección desconocida" //TODO: Localized
        }
    }
    
    public func addressCountry() -> String {
        if let address = commerce.address,
           let country = address.country
           {
            return "\(country.uppercased())"
        } else {
            return "Dirección desconocida" //TODO: Localized
        }
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = commerce.photo, let url = URL(string: imageUrl) else {
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
//
//extension DetailViewModel: MKMapViewDelegate {
//    func isEqual(_ object: Any?) -> Bool {
//        <#code#>
//    }
//    
//    var hash: Int {
//        <#code#>
//    }
//    
//    var superclass: AnyClass? {
//        <#code#>
//    }
//    
//    func `self`() -> Self {
//        <#code#>
//    }
//    
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//    
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//    
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//    
//    func isProxy() -> Bool {
//        <#code#>
//    }
//    
//    func isKind(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//    
//    func isMember(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//    
//    func conforms(to aProtocol: Protocol) -> Bool {
//        <#code#>
//    }
//    
//    func responds(to aSelector: Selector!) -> Bool {
//        <#code#>
//    }
//    
//    var description: String {
//        <#code#>
//    }
//    
//    
//}
