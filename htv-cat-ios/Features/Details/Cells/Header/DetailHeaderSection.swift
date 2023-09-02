//
//  DetailHeaderSection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class DetailHeaderSection: ListSection {
    
    weak var delegate: DetailHeaderImageCellDelegate?
    private let cellViewModel: DetailHeaderImageCellViewModel
    
    init(breedImage: BreedImageModel?, delegate: DetailHeaderImageCellDelegate) {
        self.delegate = delegate
        self.cellViewModel = DetailHeaderImageCellViewModel(breedImage: breedImage)
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        DetailHeaderImageCell.cellIdentifier
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel? {
        cellViewModel
    }
    
    func getDelegate(forRow row: Int) -> Any? {
        delegate
    }
}
