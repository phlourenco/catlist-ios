//
//  TextCellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class TextCellViewModel: CellViewModel {
    let text: String
    let fontSize: Double
    
    init(text: String, fontSize: Double) {
        self.text = text
        self.fontSize = fontSize
    }
}
