//
//  HomeViewControllerTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import SnapshotTesting
@testable import htv_cat_ios

final class HomeViewControllerTests: XCTestCase {
    func testLoadedState() {
        let mockRepository = BreedRepositoryMock()
        let viewModel = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        let vc = HomeViewController(viewModel: viewModel)
        assertSnapshot(of: vc, as: .image)
    }
    
    func testErrorState() {
        let mockRepository = BreedRepositoryMock()
        mockRepository.fetchBreedsError = true
        let viewModel = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        let vc = HomeViewController(viewModel: viewModel)
        assertSnapshot(of: vc, as: .image)
    }
    
    func testEmptyState() {
        let mockRepository = BreedRepositoryMock()
        mockRepository.breedsToReturn = 0
        let viewModel = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        let vc = HomeViewController(viewModel: viewModel)
        assertSnapshot(of: vc, as: .image)
    }
}
