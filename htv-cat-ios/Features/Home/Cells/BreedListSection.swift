//
//  BreedListSection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class BreedListSection: ListSection {
    // MARK: - Private properties
    
    private let breeds: [BreedModel]
    
    // MARK: - Constructor
    
    init(breeds: [BreedModel]) {
        self.breeds = breeds
    }
    
    // MARK: - SectionBase protocol
    
    func getNumberOfRows() -> Int {
        breeds.count
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        BreedCell.cellIdentifier
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel? {
        guard row <= breeds.count-1 else { return nil }
        
        return BreedCellViewModel(breed: breeds[row])
    }
}
