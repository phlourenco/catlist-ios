//
//  MainCoordinatorTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 4/9/23.
//

import XCTest
@testable import htv_cat_ios

class MainCoordinatorTests: XCTestCase {
    func testSingleton() {
        // Given
        let sut = MainCoordinator.shared
        
        // Then
        XCTAssertNotNil(sut.navigationController)
    }
    
    func testStart() {
        // Given
        let navigationController = UINavigationController()
        let mockCoordinator = IndependantStartableCoordinatorMock()
        let sut = MainCoordinator(breedCoordinator: mockCoordinator)
        
        // When
        sut.start()
        
        // Then
        XCTAssertEqual(mockCoordinator.startCount, 1)
        XCTAssertEqual(mockCoordinator.navigationController, sut.navigationController)
    }
}
