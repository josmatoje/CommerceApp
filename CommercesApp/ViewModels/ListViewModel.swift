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
}

final class ListViewModel: NSObject {
    
    public weak var delegate: ListViewModelDelegate?
    
    private let locationManager = CLLocationManager()
    private var totalCommerces: [Commerce] = []
    private let CATEGORIES: [Category] = [.beauty, .directSales, .electricStation, .food, .gasStation, .leisure, .shopping]
    private var commerces: [ListCellViewModel] = []
    
    private let COMMERCES_PER_LOAD: Int = 30
    private var lastIndex = 0
    private var currrentLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    public func fetchCommerces() {
        Service.shared.execute { [weak self] result in //TODO: should be weak self
            switch result {
                case .success(let model):
                    self?.totalCommerces = model
                    self?.loadInitialCommerces()
                case .failure(let error):
                    print ("Error \(error)")
            }
        }
    }
    
    public func loadInitialCommerces() {
        addCommerces()
        DispatchQueue.main.async {
            self.delegate?.didLoadTotalCommerce()
        }
    }
    
    private func addCommerces() {
        for i in lastIndex..<lastIndex+COMMERCES_PER_LOAD {
            if let commerceVM = addCommerceVM(commerce: totalCommerces[i]) {
                commerces.append(commerceVM)
            }
        }
        lastIndex += COMMERCES_PER_LOAD
    }
    
    private func addCommerceVM(commerce: Commerce) -> ListCellViewModel? {
        if let category = commerce.category, let location = commerce.location, let image = commerce.photo, let title = commerce.name, let description = commerce.address {
            
            let storeLocation = CLLocation(latitude: location[0], longitude: location[1])
            
            var distance = storeLocation.distance(from: self.currrentLocation)
            var distanceText = ""
            if distance < 1000 {
                distanceText = "\(distance.rounded()) m."
            } else if distance < 10000000 {
                distance /= 1000
                distanceText = "\(distance.rounded()) km."
            } else {
                return nil
            }
            return ListCellViewModel(category: category, distance: distanceText, imageURL: image, title: title, adress: description)
        } else {
            return nil
        }
    }
    
    private func resetComerceList() {
        commerces.removeAll()
        lastIndex = 0
    }
}

extension ListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  commerces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ListCellView.cellIdentifier,
                for: indexPath
            ) as? ListCellView else {
                fatalError("Unsupported cell")
            }
            
            cell.configure(with: commerces[indexPath.row])
            return cell
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 32, height: 150)
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
