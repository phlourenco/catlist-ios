//
//  DetailBodySectionTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

final class DetailBodySectionTests: XCTestCase {
    func testSectionSetup() {
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let sut = DetailBodySection(breed: breed)
        XCTAssertEqual(sut.getNumberOfRows(), 9)
        XCTAssertTrue(sut.getViewModel(forRow: 0) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 1) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 2) is DetailHorizontalCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 3) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 4) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 5) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 6) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 7) is TextCellViewModel)
        XCTAssertTrue(sut.getViewModel(forRow: 8) is TextCellViewModel)
        XCTAssertEqual(sut.getCellIdentifier(forRow: 0), "TextCell")
        XCTAssertEqual(sut.getEstimatedHeight(), 60)
    }
}

