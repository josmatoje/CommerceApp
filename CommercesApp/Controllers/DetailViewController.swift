//
//  DetailViewController.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import UIKit

class DetailViewController: UIViewController {

    private let scroll = UIScrollView()
    private let detailView: DetailView
    

    init(viewModel: DetailViewModel) {
        self.detailView = DetailView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString(viewModel.title(), comment: "Title")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.backBarButtonItem?.title = ""
        
        view.addSubview(scroll)
        scroll.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            detailView.topAnchor.constraint(equalTo: scroll.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            detailView.widthAnchor.constraint(equalTo: scroll.widthAnchor)
            
        ])
    }
    

}

