//
//  ListViewModel.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import UIKit
import CoreLocation

protocol ListViewModelDelegate: AnyObject {
    func didLoadTotalCommerce()
//    func didSelectCommerce(_ commerceId: Int)
}

final class ListViewModel: NSObject {
    
    public weak var delegate: ListViewModelDelegate?
    
    public let categoryDataSource = CategoryDataSource([.beauty, .directSales, .electricStation, .food, .gasStation, .leisure, .shopping])
    public let commerceDataSource = ListCellDataSource()
    
    private let locationManager = CLLocationManager()
    
    private var totalCommerces: [Commerce] = []
    private var orderListCommerces: [(Int, CLLocationDistance?)] = []
    
    private let COMMERCES_PER_LOAD: Int = 30
    private var lastIndex = 0
    private var currrentLocation: CLLocation = CLLocation(latitude: 40.416880, longitude: -3.703837) //Madrid km. 0 40.416880, -3.703837
    
    public func filterCommercesbyCategory() -> [Commerce] {
        guard let selectecCategory = categoryDataSource.selectedCategory else {
            return totalCommerces
        }
        return totalCommerces.filter { $0.category == selectecCategory }
    }
    
    public func filterCommercesby(distance: Int) -> [Commerce] {
        orderListCommerces.filter {
            $0.1 ?? 0 <= Double(distance * 1000)
        }.compactMap { commerce in
            self.totalCommerces.first {
                $0.id == commerce.0
            }
        }
    }
    
    public var filterCommercesCount: Int {
        filterCommercesbyCategory().count
    }
    
    public var shouldShowLoadMore: Bool {
        return lastIndex < filterCommercesCount
    }
    
    public func getCommerce(for id: Int) -> Commerce? {
        totalCommerces.first { $0.id == id } ?? nil
    }
    
    public func fetchCommerces() {
        Service.shared.execute { [weak self] result in 
            switch result {
                case .success(let model):
                    self?.totalCommerces = model
                    model.forEach { [weak self] commerce in
                        self?.orderListCommerces.append(
                            (
                                commerce.id ?? 0,
                                self?.currrentLocation.distance(from: CLLocation(
                                                                        latitude: commerce.location?[1] ?? 0,
                                                                        longitude: commerce.location?[0] ?? 0
                                                                                )
                                                                ) ?? 0
                            )
                        )
                    }
                self?.orderListCommerces.sort {
                    if let firstDistance = $0.1, let secondDistance = $1.1 {
                        return firstDistance < secondDistance
                    } else {
                        return false
                    }
                }
                    self?.loadInitialCommerces()
                case .failure(let error):
                    print ("Error \(error)")
            }
        }
    }
    
    public func loadInitialCommerces() {
        repeat { //Load all datas but is slower
            addCommerces()
        } while lastIndex < filterCommercesCount
        DispatchQueue.main.async {
            self.delegate?.didLoadTotalCommerce()
        }
    }
    
    private func addCommerces() {
        let maximumIndex = lastIndex + COMMERCES_PER_LOAD >= filterCommercesCount ? filterCommercesCount : lastIndex+COMMERCES_PER_LOAD

        for i in lastIndex ..< maximumIndex{
            if let commerce = filterCommercesbyCategory().first(where: { $0.id ?? 0 == orderListCommerces[i].0 }) {
                if let commerceVM = addCommerceVM(commerce: commerce) {
                    commerceDataSource.commerces.append(commerceVM)
                }
            }
        }
        lastIndex += COMMERCES_PER_LOAD
        
    }
    
    private func addCommerceVM(commerce: Commerce) -> ListCellViewModel? {
        if let id = commerce.id, let category = commerce.category, let location = commerce.location, let image = commerce.photo, let title = commerce.name, let description = commerce.address {
            
            let storeLocation = CLLocation(latitude: location[1], longitude: location[0])
            
            var distance = storeLocation.distance(from: self.currrentLocation)
            var distanceText = ""
            if distance < 1000 {
                distanceText = "\(distance.rounded()) m."
            } else { //} if distance < 10000000 {
                distance /= 1000
                distanceText = "\(distance.rounded()) km."
//            } else {
//                return nil
            }
            let viewModel = ListCellViewModel(id: id, category: category, distance: distanceText, imageURL: image, title: title, address: description)
            return viewModel
        } else {
            return nil
        }
    }
    
    public func resetComerceList() {
        commerceDataSource.commerces.removeAll()
        lastIndex = 0
    }
    
    public func filterCommerces(byCategory category: Category) {
        resetComerceList()
        loadInitialCommerces()
    }
}

extension ListViewModel: CLLocationManagerDelegate {
    
    func askPermissions() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue = locations.last else { return }
        currrentLocation = CLLocation(latitude: locationValue.coordinate.latitude, longitude: locationValue.coordinate.longitude)
    }
}

extension ListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMore else { return }
    }
}
