//
//  HomeFactoryTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 4/9/23.
//

import XCTest
@testable import htv_cat_ios

class HomeFactoryTests: XCTestCase {
    func testMake() {
        let sut = HomeFactory()
        do {
            let result = try sut.make(parameters: [], coordinatorDelegate: nil)
            XCTAssertTrue(result is HomeViewController)
        } catch {
            XCTFail("Should not throw")
        }
    }
}
