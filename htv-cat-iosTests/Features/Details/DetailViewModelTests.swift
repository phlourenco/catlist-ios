//
//  DetailViewModelTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import Combine
@testable import htv_cat_ios

final class DetailViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testInitialState() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        
        // When
        let sut = DetailViewModel(breed: breed, repository: mockRepository, scheduler: .immediate)
        
        // Then
        XCTAssertEqual(mockRepository.fetchBreedImagesCount, 0)
        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sut.sections.count, 2)
    }
    
    func testBackSubject() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let sut = DetailViewModel(breed: breed, repository: mockRepository, scheduler: .immediate)
        
        let expectation = XCTestExpectation(description: "Back subject emits an event.")
        
        // When
        sut.backSubject
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sut.back()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testSuccessGetDetails() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let sut = DetailViewModel(breed: breed, repository: mockRepository, scheduler: .immediate)
        
        guard let headerSectionWithoutImage = sut.sections[0].getViewModel(forRow: 0) as? DetailHeaderImageCellViewModel else {
            XCTFail("First section VM should be DetailHeaderImageCellViewModel")
            return
        }
        
        // When
        sut.getDetails()
        
        // Then
        XCTAssertEqual(mockRepository.fetchBreedImagesCount, 1)
        
        if case ViewState.loaded(_) = sut.state {} else {
            XCTFail("State should be loaded")
        }
        
        guard let headerSectionWithImage = sut.sections[0].getViewModel(forRow: 0) as? DetailHeaderImageCellViewModel else {
            XCTFail("First section VM should be DetailHeaderImageCellViewModel")
            return
        }
        XCTAssertNil(headerSectionWithoutImage.breedImage)
        XCTAssertNotNil(headerSectionWithImage.breedImage)
    }
    
    func testErrorThenRetry() throws {
        // Given
        let mockRepository = BreedRepositoryMock()
        mockRepository.fetchBreedImagesError = true
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let sut = DetailViewModel(breed: breed, repository: mockRepository, scheduler: .immediate)
        
        // When
        sut.getDetails()
        
        // Then
        XCTAssertEqual(mockRepository.fetchBreedImagesCount, 1)
        
        if case let ViewState.error(HTTPError.invalidResponse, retryFunction) = sut.state {
            mockRepository.fetchBreedsError = false
            retryFunction?()
            XCTAssertEqual(mockRepository.fetchBreedImagesCount, 2)
        } else {
            XCTFail("State should be error (HTTPError.invalidResponse)")
        }
    }
}
