//
//  HomeViewController.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController, BaseView {
    
    // MARK: - Properties
    
    weak var delegate: BreedCoordinatorDelegate?
    private let viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var adapter = CollectionViewAdapter(sections: [])
    
    // MARK: - UI elements
    
    private var collectionView: UICollectionView!
    
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
        bindViewModel()
        viewModel.getCatBreeds()
    }
    
    // MARK: - Private methods
    
    private func createLayout() -> UICollectionViewLayout {
        let estimatedHeight: CGFloat = 100
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupViews() {
        // MARK: - Setup VC
        view.backgroundColor = .white
        navigationItem.title = "Cat Breeds"
        
        adapter.delegate = self

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        collectionView.register(BreedCell.self, forCellWithReuseIdentifier: BreedCell.cellIdentifier)
        
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
    }
    
    private func handleState(_ state: ViewState) {
        print("new state: \(state)")
        
        adapter.sections = viewModel.sections
        collectionView.reloadData()
        
        switch state {
        case .loading:
            showScreenLoading()
        case .loaded:
            hideScreenLoading()
        case .error(_, let retry):
            hideScreenLoading()
            showAlert(title: "Oops!", message: "Something went wrong. Please check your connection and try again.", tryAgainAction: retry, completion: nil)
        default:
            break
        }
    }
}

extension HomeViewController: CollectionViewAdapterDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath)")
        let breed = viewModel.breeds[indexPath.row]
        delegate?.showDetail(breed: breed)
    }
    
    func willDisplayLastCell() {
        print("willDisplayLastCell")
        viewModel.getCatBreeds(nextPage: true)
    }
}
