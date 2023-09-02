//
//  ImageSearchEndpoint.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

class ImageSearchEndpoint: HTTPRequest {
    var method: HTTPMethod = .GET
    
    var path: String = "/images/search"
    
    var parameters: [URLQueryItem] {
        return [
            .init(name: "breed_ids", value: breedId)
        ]
    }
    
    private let breedId: String
    
    init(breedId: String) {
        self.breedId = breedId
    }
}
