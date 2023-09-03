//
//  ViewStateTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import Combine
@testable import htv_cat_ios

class ViewStateTests: XCTestCase {
    func testIdleComparison() {
        let state1 = ViewState.idle
        let state2 = ViewState.idle
        XCTAssertEqual(state1, state2)
    }
    
    func testLoadingComparison() {
        let state1 = ViewState.loading
        let state2 = ViewState.loading
        XCTAssertEqual(state1, state2)
    }
    
    func testLoadedComparison() {
        XCTAssertNotEqual(ViewState.loaded(empty: false), ViewState.loaded(empty: true))
        XCTAssertNotEqual(ViewState.loaded(empty: true), ViewState.loaded(empty: false))
        XCTAssertEqual(ViewState.loaded(empty: true), ViewState.loaded(empty: true))
        XCTAssertEqual(ViewState.loaded(empty: false), ViewState.loaded(empty: false))
    }
    
    func testErrorComparison() {
        XCTAssertNotEqual(ViewState.error(AppError.unknownError, nil), ViewState.error(HTTPError.invalidResponse, nil))
    }
    
    func testDifferentStatesComparison() {
        let state1 = ViewState.idle
        let state2 = ViewState.loading
        XCTAssertNotEqual(state1, state2)
    }
}
