//
//  DetailHeaderSectionTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

final class DetailHeaderSectionTests: XCTestCase {
    func testSectionSetup() {
        let sut = DetailHeaderSection(breedImage: nil, delegate: nil)
        XCTAssertEqual(sut.getNumberOfRows(), 1)
        XCTAssertTrue(sut.getViewModel(forRow: 0) is DetailHeaderImageCellViewModel)
        XCTAssertEqual(sut.getCellIdentifier(forRow: 0), "DetailHeaderImageCell")
        XCTAssertNil(sut.getDelegate(forRow: 0))
        XCTAssertEqual(sut.getEstimatedHeight(), 300)
    }
}

