//
//  ListViewController.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import UIKit
import CoreLocation

final class ListViewController: UIViewController, ListViewDelegate {

    private let listView = ListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = NSLocalizedString("list_title", comment: "Title")
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        listView.delegate = self
        
        view.addSubview(listView)
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func listView(_ listView: ListView, didSelectCommerce commerce: Commerce) {
        //Open detail controller to commerce
        let viewModel = DetailViewModel(commerce: commerce)
        let detailViewController = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}

