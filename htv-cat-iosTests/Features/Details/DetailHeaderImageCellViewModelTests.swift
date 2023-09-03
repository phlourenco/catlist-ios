//
//  DetailHeaderImageCellViewModelTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

final class DetailHeaderImageCellViewModelTests: XCTestCase {
    func testInitNil() {
        let sut = DetailHeaderImageCellViewModel(breedImage: nil)
        XCTAssertNil(sut.breedImage)
    }
    
    func testInitWithImage() {
        let breedImage = BreedImageModel(id: "id", url: URL(string: "https://cdn2.thecatapi.com/images/unPP08xOZ.jpg")!, width: 2136, height: 2848)
        let sut = DetailHeaderImageCellViewModel(breedImage: breedImage)
        XCTAssertNotNil(sut.breedImage)
    }
}


