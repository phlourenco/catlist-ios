//
//  CollectionViewAdapter.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

protocol CollectionViewAdapterDelegate: AnyObject {
    func didSelectRowAt(indexPath: IndexPath)
    func willDisplayLastCell()
}

class CollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - Properties
    
    var sections: [ListSection]
    weak var delegate: CollectionViewAdapterDelegate?
    
    // MARK: - Constructor
    
    init(sections: [ListSection]) {
        self.sections = sections
    }
    
    // MARK: - UICollectionViewDelegate & UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let cellIdentifier = section.getCellIdentifier(forRow: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        if let cellViewModel = section.getViewModel(forRow: indexPath.row) {
            (cell as? ConfigurableCell)?.configure(viewModel: cellViewModel, delegate: section.getDelegate(forRow: indexPath.row))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == sections[indexPath.section].getNumberOfRows() - 1, collectionView.contentOffset.y >= 10 {
            delegate?.willDisplayLastCell()
        }
    }
}
