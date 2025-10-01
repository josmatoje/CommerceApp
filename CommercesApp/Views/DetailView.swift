//
//  DetailView.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 29/9/25.
//

import UIKit
import MapKit

final class DetailView: UIView {
    
    private var viewModel: DetailViewModel

    private let imageDetail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    } ()
    
    private let localizationTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.text = "Localización" //TODO: Localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let mapLink: UIButton = {
        let button = UIButton()
        button.setTitle("Llévame aquí", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.systemTeal, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let mapView:MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    } ()
    
    private let addressBanner: AddressBannerView = {
        let addressBannerView = AddressBannerView(frame: .zero)
        addressBannerView.translatesAutoresizingMaskIntoConstraints = false
        return addressBannerView
    } ()
    
    private let commerceTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.text = "Sobre el comercio" //TODO: Localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let openBanner: DetailBannerView = {
        let openBanner = DetailBannerView(frame: .zero)
        openBanner.translatesAutoresizingMaskIntoConstraints = false
        return openBanner
    } ()
    
    // MARK: init
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        
        addSubviews(imageDetail, localizationTitle, mapLink, mapView, addressBanner, commerceTitle, openBanner)
        addConstraints()
        configure(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    // MARK: functions
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            imageDetail.heightAnchor.constraint(equalToConstant: 180),
            imageDetail.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            imageDetail.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            imageDetail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            localizationTitle.topAnchor.constraint(equalTo: imageDetail.bottomAnchor, constant: 32),
            localizationTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            mapLink.topAnchor.constraint(equalTo: imageDetail.bottomAnchor, constant: 32),
            mapLink.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            mapView.heightAnchor.constraint(equalToConstant: 300),
            mapView.topAnchor.constraint(equalTo: localizationTitle.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            addressBanner.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 32),
            addressBanner.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addressBanner.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addressBanner.bottomAnchor.constraint(equalTo: commerceTitle.topAnchor, constant: -32),
            
            commerceTitle.topAnchor.constraint(equalTo: addressBanner.bottomAnchor, constant: 32),
            commerceTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            commerceTitle.bottomAnchor.constraint(equalTo: openBanner.topAnchor, constant: -32),
            
            openBanner.topAnchor.constraint(equalTo: commerceTitle.bottomAnchor, constant: 32),
            openBanner.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            openBanner.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            openBanner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
            
        ])
    }
    
    private func configure(viewModel: DetailViewModel) {
        
        centerMap()
        mapLink.addTarget(self, action: #selector(centerMap), for: .touchUpInside)
        addressBanner.configure(
            with: .systemBackground,
            streetText: viewModel.addressStreet(),
            cityText: viewModel.addressCity(),
            countryText: viewModel.addressCountry()
        )
        
        if viewModel.openingHours().isEmpty {
            openBanner.configure(
                with: .systemBackground,
                descriptionText: "Como no tenemos horario aquí tienes el cashbak: \(viewModel.cashBack())"
            )
        } else {
            openBanner.configure(
                with: .systemBackground,
                descriptionText: viewModel.openingHours()
            )
        }
        
        viewModel.fetchImage { [weak self] result in //weak for no memory leaks from the cells by the image
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        let image = UIImage(data: image)
                        self?.imageDetail.image = image
                    }
                case .failure:
                    print("Error fetching image")
                    DispatchQueue.main.async {
                        let image: UIImage? = UIImage(named: "only_image")
//                        let image: UIImage? = UIImage(named: "placeholder")
                        self?.imageDetail.image = image
                    }
                    break
                }
        }
    }
    
    @objc private func centerMap() {
        mapView.camera = MKMapCamera(lookingAtCenter: viewModel.location(), fromDistance: 2500, pitch: 0, heading: 0)
    }
}
