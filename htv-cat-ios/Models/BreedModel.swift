//
//  BreedModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

struct BreedModel: Decodable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let description: String
//    let referenceImageId: String
}
