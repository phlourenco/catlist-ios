//
//  DetailHeaderImageCellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class DetailHeaderImageCellViewModel: CellViewModel {
    
    private(set) var breedImage: BreedImageModel?
    
    init(breedImage: BreedImageModel?) {
        self.breedImage = breedImage
    }
    
}
