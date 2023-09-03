//
//  BreedCellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

final class BreedCellViewModel: CellViewModel {
    var title: String
    let description: String
    
    init(breed: BreedModel) {
        title = breed.name
        if let countryEmoji = breed.countryCode.toCountryFlagEmoji() {
            title.append(" \(countryEmoji)")
        }
        description = breed.description
    }
}
