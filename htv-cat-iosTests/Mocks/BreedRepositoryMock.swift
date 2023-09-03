//
//  BreedRepositoryMock.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import Foundation
import Combine
@testable import htv_cat_ios

final class BreedRepositoryMock: IBreedRepository {
    var breedsToReturn = 10
    var fetchBreedsError = false
    var fetchBreedsCount = 0
    var fetchBreedImagesError = false
    var fetchBreedImagesCount = 0
    
    func fetchBreeds(page: Int, limit: Int) -> AnyPublisher<[BreedModel], Error> {
        fetchBreedsCount += 1
        
        if fetchBreedsError {
            return Fail(error: HTTPError.invalidResponse).eraseToAnyPublisher()
        }
        
        let breeds = MockHelper.shared.generateBreeds(count: breedsToReturn)
        
        return Just(breeds)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchBreedImages(breedId: String) -> AnyPublisher<[BreedImageModel], Error> {
        fetchBreedImagesCount += 1
        
        if fetchBreedImagesError {
            return Fail(error: HTTPError.invalidResponse).eraseToAnyPublisher()
        }
        
        let jsonData = MockHelper.shared.loadJson(name: "image_search_endpoint_success")!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return Just(jsonData)
            .decode(type: [BreedImageModel].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
