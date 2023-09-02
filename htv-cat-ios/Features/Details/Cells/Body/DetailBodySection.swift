//
//  DetailBodySection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class DetailBodySection: ListSection {
    private let breed: BreedModel
    
    init(breed: BreedModel) {
        self.breed = breed
    }
    
    func getNumberOfRows() -> Int {
        2
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        TextCell.cellIdentifier
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel? {
        if row == 0 {
            return TextCellViewModel(text: breed.name, fontSize: 30)
        } else {
            return TextCellViewModel(text: breed.description, fontSize: 15)
        }
    }
}
