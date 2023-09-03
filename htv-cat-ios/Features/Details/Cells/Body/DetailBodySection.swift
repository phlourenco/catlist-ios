//
//  DetailBodySection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

typealias CellViewModelWithId = (identifier: String, viewModel: CellViewModel)

final class DetailBodySection: ListSection {
    private let breed: BreedModel
    private var cellViewModels: [CellViewModelWithId] = []
    
    init(breed: BreedModel) {
        self.breed = breed
        
        // create cell viewmodels only once, so they are reused when collectionView is reloaded
        createCellViewModels()
    }
    
    func getNumberOfRows() -> Int {
        cellViewModels.count
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        cellViewModels[row].identifier
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel? {
        cellViewModels[row].viewModel
    }
    
    func getEstimatedHeight() -> CGFloat {
        60
    }
    
    private func createCellViewModels() {
        let temperament = breed.temperament.replacingOccurrences(of: ", ", with: "\n")
        let origin = breed.origin.appending(breed.countryCode.toCountryFlagEmoji() ?? "")
        let lifeSpan = "\(breed.lifeSpan) years"
        cellViewModels = [
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: breed.name, fontSize: 30, type: .title)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: breed.description, fontSize: 15, type: .description)),
            CellViewModelWithId(DetailHorizontalCell.cellIdentifier, DetailHorizontalCellViewModel(breed: breed)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: "Origin", fontSize: 20, type: .title)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: origin, fontSize: 15, type: .description)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: "Life span", fontSize: 20, type: .title)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: lifeSpan, fontSize: 15, type: .description)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: "Temperament", fontSize: 20, type: .title)),
            CellViewModelWithId(TextCell.cellIdentifier, TextCellViewModel(text: temperament, fontSize: 15, type: .description))
        ]
    }
}
