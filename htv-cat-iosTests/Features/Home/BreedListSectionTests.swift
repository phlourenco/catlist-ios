//
//  BreedListSection.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

final class BreedListSectionTests: XCTestCase {
    func testSectionSetup() {
        let breeds = MockHelper.shared.generateBreeds(count: 5)
        let sut = BreedListSection(breeds: breeds)
        XCTAssertEqual(sut.getNumberOfRows(), 5)
        for i in 0..<sut.getNumberOfRows() {
            XCTAssertTrue(sut.getViewModel(forRow: i) is BreedCellViewModel)
            XCTAssertEqual(sut.getCellIdentifier(forRow: i), "BreedCell")
        }
    }
    
    func testSectionEmptySetup() {
        let sut = BreedListSection(breeds: [])
        XCTAssertEqual(sut.getNumberOfRows(), 0)
        XCTAssertNil(sut.getViewModel(forRow: 10))
        XCTAssertNil(sut.getDelegate(forRow: 0))
        XCTAssertEqual(sut.getEstimatedHeight(), 100)
    }
}
