//
//  DetailViewController.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit
import Combine

final class DetailViewController: UIViewController, BaseView {
    
    // MARK: - Properties
    
    private let viewModel: DetailViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var adapter = CollectionViewAdapter(sections: [])
    
    // MARK: - UI elements
    
    private var collectionView: UICollectionView!
    
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
        setupViews()
        bindViewModel()
        
//        adapter.sections = [
//            DetailHeaderSection(delegate: self),
//            DetailBodySection()
//        ]
//        collectionView.reloadData()
        
        viewModel.getDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private methods
    
    private func createLayout() -> UICollectionViewLayout {
        let estimatedHeight: CGFloat = 300
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.breed.name

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.cellIdentifier)
        collectionView.register(DetailHeaderImageCell.self, forCellWithReuseIdentifier: DetailHeaderImageCell.cellIdentifier)
        
        view.addSubview(collectionView)
        
        UIView.addConstraints([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$state
            .sink(receiveValue: handleState)
            .store(in: &cancellables)
        
        viewModel.backSubject
            .sink { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func handleState(_ state: ViewState) {
        print("DETAIL new state: \(state)")
        
        
        adapter.sections = viewModel.sections
        collectionView.reloadData()
        switch state {
//        case .loaded:
//            break
        case .error(_, let retry):
            showAlert(title: "Oops!", message: "Something went wrong. Please check your connection and try again.", tryAgainAction: retry, completion: nil)
            break
        default:
            break
        }
    }
}
