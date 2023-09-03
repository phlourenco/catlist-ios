//
//  BreedListEndpointTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

class BreedListEndpointTests: XCTestCase {
    func testInit() {
        let sut = BreedListEndpoint(page: 0, limit: 10)
        XCTAssertEqual(sut.method, .GET)
        XCTAssertEqual(sut.path, "/breeds")
        XCTAssertEqual(sut.parameters.count, 2)
        XCTAssertEqual(sut.parameters[0].name, "limit")
        XCTAssertEqual(sut.parameters[0].value, "10")
        XCTAssertEqual(sut.parameters[1].name, "page")
        XCTAssertEqual(sut.parameters[1].value, "0")
    }
}
