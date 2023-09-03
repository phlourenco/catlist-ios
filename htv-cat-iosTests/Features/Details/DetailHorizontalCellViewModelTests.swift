//
//  DetailHorizontalCellViewModelTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

final class DetailHorizontalCellViewModelTests: XCTestCase {
    func testInit() {
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let sut = DetailHorizontalCellViewModel(breed: breed)
        XCTAssertEqual(sut.details.count, 9)
    }
}


