//
//  CollectionViewCellSnapshotContainer.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import UIKit

final class CollectionViewCellSnapshotContainer<Cell: UICollectionViewCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias CellConfigurator = (_ cell: Cell) -> ()

    private var collectionView: UICollectionView!
    private let configureCell: (Cell) -> ()
    private let defaultWidth: CGFloat = 500
    private let cellIdentifier: String
    private let estimatedHeight: CGFloat
    
    init(cellIdentifier: String, estimatedHeight: CGFloat, configureCell: @escaping CellConfigurator) {
        self.configureCell = configureCell
        self.cellIdentifier = cellIdentifier
        self.estimatedHeight = estimatedHeight
        
        super.init(frame: .zero)
        
        backgroundColor = .orange
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout(estimatedHeight: estimatedHeight))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
                
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            widthAnchor.constraint(equalToConstant: defaultWidth),
            heightAnchor.constraint(equalToConstant: estimatedHeight)
        ])
        
        layoutSubviews()
    }
    
    private func createLayout(estimatedHeight: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let sectionLayout = NSCollectionLayoutSection(group: group)
            return sectionLayout
        }
        
        return layout
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
        configureCell(cell)
        return cell
    }
}
