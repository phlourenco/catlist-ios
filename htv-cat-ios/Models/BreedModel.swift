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
    let countryCode: String
    let description: String
    let lifeSpan: String
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let energyLevel: Int
    let healthIssues: Int
    let intelligence: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let rare: Int
}
