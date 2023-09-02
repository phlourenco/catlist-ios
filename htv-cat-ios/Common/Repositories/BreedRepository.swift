//
//  BreedRepository.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation
import Combine

protocol IBreedRepository {
    func fetchBreeds(page: Int, limit: Int) -> AnyPublisher<[BreedModel], Error>
}

final class BreedRepository: IBreedRepository {
    private let httpClient: IHTTPClient
    
    init(httpClient: IHTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchBreeds(page: Int, limit: Int) -> AnyPublisher<[BreedModel], Error> {
        let endpoint = BreedListEndpoint(page: page, limit: limit)
        return httpClient.requestObject(request: endpoint)
    }
}
