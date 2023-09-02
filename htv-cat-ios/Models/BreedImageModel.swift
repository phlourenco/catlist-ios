//
//  BreedImageModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

struct BreedImageModel: Decodable {
    let id: String
    let url: URL
    let width: Double
    let height: Double
}
