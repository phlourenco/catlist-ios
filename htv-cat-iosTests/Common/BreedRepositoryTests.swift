//
//  BreedRepositoryTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import Combine
@testable import htv_cat_ios

class BreedRepositoryTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testFetchBreedsSuccess() {
        let breeds = MockHelper.shared.generateBreeds(count: 10)
        
        let httpMock = HTTPClientMock()
        httpMock.objectToReturn = breeds
        
        let sut = BreedRepository(httpClient: httpMock)
        
        let expectation = XCTestExpectation(description: "Success is expected")
        
        var returnedBreeds: [BreedModel] = []
        
        sut.fetchBreeds(page: 0, limit: 10)
            .sink { result in
                switch result {
                case .failure(_):
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                returnedBreeds = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(breeds.count, returnedBreeds.count)
    }
    
    func testFetchBreedsFail() {
        let httpMock = HTTPClientMock()
        httpMock.error = true
        
        let sut = BreedRepository(httpClient: httpMock)
        
        let expectation = XCTestExpectation(description: "Failure is expected")
        
        sut.fetchBreeds(page: 0, limit: 10)
            .sink { result in
                switch result {
                case .failure(_):
                    expectation.fulfill()
                case .finished:
                    break
                }
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchBreedImagesSuccess() {
        let httpMock = HTTPClientMock()
        httpMock.objectToReturn = [BreedImageModel(id: "id", url: URL(string: "https://cdn2.thecatapi.com/images/unPP08xOZ.jpg")!, width: 2136, height: 2848)]
        
        let sut = BreedRepository(httpClient: httpMock)
        
        let expectation = XCTestExpectation(description: "Success is expected")
        
        var returnedBreedImages: [BreedImageModel] = []
        
        sut.fetchBreedImages(breedId: "id")
            .sink { result in
                switch result {
                case .failure(_):
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                returnedBreedImages = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(returnedBreedImages.count, 1)
    }
    
    func testFetchBreedImagesFail() {
        let httpMock = HTTPClientMock()
        httpMock.error = true
        
        let sut = BreedRepository(httpClient: httpMock)
        
        let expectation = XCTestExpectation(description: "Back subject emits an event.")
        
        sut.fetchBreedImages(breedId: "id")
            .sink { result in
                switch result {
                case .failure(_):
                    expectation.fulfill()
                case .finished:
                    break
                }
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
}
