//
//  DetailViewController.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: DetailViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI elements
    
    
    // MARK: - Constructor
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = viewModel.breed.name
    }
}
