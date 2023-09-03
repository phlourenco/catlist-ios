//
//  BreedCellViewModelTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

final class BreedCellViewModelTests: XCTestCase {
    func testTitleWithoutCountryFlagEmoji() throws {
        let breed = BreedModel(
            id: "id",
            name: "Whatever",
            temperament: "",
            origin: "UnknownCountry",
            countryCode: "ZZ",
            description: "This is a test description",
            lifeSpan: "10 - 15",
            adaptability: 5,
            affectionLevel: 5,
            childFriendly: 5,
            energyLevel: 5,
            healthIssues: 5,
            intelligence: 5,
            socialNeeds: 5,
            strangerFriendly: 5,
            rare: 5
        )
        
        let sut = BreedCellViewModel(breed: breed)
        XCTAssertEqual(sut.title, "Whatever")
    }
    func testTitleWithCountryFlagEmoji() throws {
        let breed = BreedModel(
            id: "id",
            name: "Whatever",
            temperament: "",
            origin: "Brazil",
            countryCode: "BR",
            description: "This is another test description",
            lifeSpan: "10 - 15",
            adaptability: 5,
            affectionLevel: 5,
            childFriendly: 5,
            energyLevel: 5,
            healthIssues: 5,
            intelligence: 5,
            socialNeeds: 5,
            strangerFriendly: 5,
            rare: 5
        )
        
        let sut = BreedCellViewModel(breed: breed)
        XCTAssertEqual(sut.title, "Whatever 🇧🇷")
    }
}
