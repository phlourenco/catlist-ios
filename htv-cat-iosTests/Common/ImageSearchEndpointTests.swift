//
//  ImageSearchEndpointTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
@testable import htv_cat_ios

class ImageSearchEndpointTests: XCTestCase {
    func testInit() {
        let sut = ImageSearchEndpoint(breedId: "test")
        XCTAssertEqual(sut.method, .GET)
        XCTAssertEqual(sut.path, "/images/search")
        XCTAssertEqual(sut.parameters.count, 1)
        XCTAssertEqual(sut.parameters[0].name, "breed_ids")
        XCTAssertEqual(sut.parameters[0].value, "test")
    }
}
