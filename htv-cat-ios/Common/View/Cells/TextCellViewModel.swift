//
//  TextCellViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class TextCellViewModel: CellViewModel {
    enum TextType {
        case title
        case description
    }
    
    let text: String
    let fontSize: Double
    let type: TextType
    
    init(text: String, fontSize: Double, type: TextType) {
        self.text = text
        self.fontSize = fontSize
        self.type = type
    }
}
