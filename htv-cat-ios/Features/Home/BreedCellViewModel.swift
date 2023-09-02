//
//  BreedCellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

final class BreedCellViewModel: CellViewModel {
    let breed: BreedModel
    
    init(breed: BreedModel) {
        self.breed = breed
    }
}
