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
        let state1 = ViewState.loaded
        let state2 = ViewState.loaded
        XCTAssertEqual(state1, state2)
    }
    
    func testEmptyComparison() {
        let state1 = ViewState.empty
        let state2 = ViewState.empty
        XCTAssertEqual(state1, state2)
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
