//
//  BreedCoordinatorTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 4/9/23.
//

import XCTest
@testable import htv_cat_ios

class BreedCoordinatorTests: XCTestCase {
    func testStart() {
        // Given
        let navigationController = SpyNavigationController()
        let homeFactory = FactoryMock()
        let detailFactory = FactoryMock()
        let sut = BreedCoordinator(
            homeFactory: homeFactory,
            detailFactory: detailFactory
        )
        
        // When
        sut.start(with: navigationController)
        
        // Then
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers[0], homeFactory.madeViewController)
    }
    
    func testShowDetail() {
        // Given
        let navigationController = SpyNavigationController()
        print("SPY: \(navigationController)")
        let homeFactory = FactoryMock()
        let detailFactory = FactoryMock()
        let sut = BreedCoordinator(
            homeFactory: homeFactory,
            detailFactory: detailFactory
        )
        
        // When
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        sut.start(with: navigationController)
        sut.showDetail(breed: breed)
        
        // Then
        XCTAssertEqual(navigationController.pushedViewControllers.count, 1)
        XCTAssertEqual(navigationController.pushedViewControllers[0], detailFactory.madeViewController)
    }
}

class SpyNavigationController: UINavigationController {
    var pushedViewControllers: [UIViewController] = []
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        super.pushViewController(viewController, animated: animated)
    }
}
