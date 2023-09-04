//
//  DetailFactoryTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 4/9/23.
//

import XCTest
@testable import htv_cat_ios

class DetailFactoryTests: XCTestCase {
    func testMakeSuccess() {
        let sut = DetailFactory()
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        do {
            let result = try sut.make(parameters: [breed], coordinatorDelegate: nil)
            XCTAssertTrue(result is DetailViewController)
        } catch {
            XCTFail("Should not throw")
        }
    }
    
    func testMakeError() throws {
        let sut = DetailFactory()
        do {
            let result = try sut.make(parameters: [], coordinatorDelegate: nil)
            XCTFail("Failing because it should throw an error")
        } catch {
            //test is ok, should throw
        }
    }
}
