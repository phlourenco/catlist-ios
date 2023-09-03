//
//  HomeViewModelTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import Combine
@testable import htv_cat_ios

final class HomeViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testSuccesFirstPage() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        let sut = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        XCTAssertEqual(mockRepository.fetchBreedsCount, 0)
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.breeds.count, 0)
        XCTAssertEqual(sut.sections.count, 0)
        
        // When
        sut.getCatBreeds(nextPage: false)
        
        // Then
        XCTAssertEqual(mockRepository.fetchBreedsCount, 1)
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.breeds.count, 10)
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertTrue(sut.sections.first is BreedListSection)
    }
    
    func testSuccesSecondPage() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        let sut = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        XCTAssertEqual(mockRepository.fetchBreedsCount, 0)
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.breeds.count, 0)
        XCTAssertEqual(sut.sections.count, 0)
        
        // When
        sut.getCatBreeds(nextPage: false)
        sut.getCatBreeds(nextPage: true)
        
        // Then
        XCTAssertEqual(mockRepository.fetchBreedsCount, 2)
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.breeds.count, 20)
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertTrue(sut.sections.first is BreedListSection)
    }
    
    func testErrorThenRetry() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        mockRepository.fetchBreedsError = true
        
        let sut = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        XCTAssertEqual(mockRepository.fetchBreedsCount, 0)
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.breeds.count, 0)
        XCTAssertEqual(sut.sections.count, 0)
        
        // When
        sut.getCatBreeds(nextPage: false)
        
        // Then
        XCTAssertEqual(mockRepository.fetchBreedsCount, 1)
        XCTAssertEqual(sut.breeds.count, 0)
        XCTAssertEqual(sut.sections.count, 0)
        if case let ViewState.error(HTTPError.invalidResponse, retryFunction) = sut.state {
            mockRepository.fetchBreedsError = false
            retryFunction?()
            XCTAssertEqual(mockRepository.fetchBreedsCount, 2)
            XCTAssertEqual(sut.breeds.count, 10)
            XCTAssertEqual(sut.sections.count, 1)
        } else {
            XCTFail("State should be error (HTTPError.invalidResponse)")
        }
    }
    
    func testDontFetchAgainAfterLastPageIsFetched() throws {
        // Given that only 9 breeds are returned (and the limit of the page is 10)
        let mockRepository = BreedRepositoryMock()
        mockRepository.breedsToReturn = 9
        let sut = HomeViewModel(repository: mockRepository, scheduler: .immediate)
        
        XCTAssertEqual(mockRepository.fetchBreedsCount, 0)
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.breeds.count, 0)
        XCTAssertEqual(sut.sections.count, 0)
        
        sut.getCatBreeds(nextPage: false)
        
        // When tries to fetch the next page
        sut.getCatBreeds(nextPage: true)
        
        // Then it's not fetched, because by receiving only 9 items from the previous request it means that there are no more pages to fetch
        XCTAssertEqual(mockRepository.fetchBreedsCount, 1)
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.breeds.count, 9)
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertTrue(sut.sections.first is BreedListSection)
    }
}
