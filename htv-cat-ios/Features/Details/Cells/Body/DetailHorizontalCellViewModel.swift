//
//  DetailHorizontalCellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

struct BreedDetailItem {
    let title: String
    let value: String
}

final class DetailHorizontalCellViewModel: CellViewModel {
    private(set) var details: [BreedDetailItem] = []
    
    init(breed: BreedModel) {
        details.append(.init(title: "adaptability", value: "\(breed.adaptability)"))
        details.append(.init(title: "affection level", value: "\(breed.affectionLevel)"))
        details.append(.init(title: "child friendly", value: "\(breed.childFriendly)"))
        details.append(.init(title: "energy level", value: "\(breed.energyLevel)"))
        details.append(.init(title: "health issues", value: "\(breed.healthIssues)"))
        details.append(.init(title: "intelligence", value: "\(breed.intelligence)"))
        details.append(.init(title: "social needs", value: "\(breed.socialNeeds)"))
        details.append(.init(title: "stranger friendly", value: "\(breed.strangerFriendly)"))
        details.append(.init(title: "rare", value: "\(breed.rare)"))
        details.shuffle()
    }
}
