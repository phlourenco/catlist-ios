//
//  HomeViewController.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    
    // MARK: - UI elements
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "label"
        return lbl
    }()
    
    // MARK: - Constructor
    
    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        // MARK: - Setup VC
        view.backgroundColor = .red
        
        // MARK: - Setup Label
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
