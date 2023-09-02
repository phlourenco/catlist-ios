//
//  BreedListEndpoint.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

class BreedListEndpoint: HTTPRequest {
    var method: HTTPMethod = .GET
    
    var path: String = "/breeds"
    
    var parameters: [URLQueryItem] {
        return [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "page", value: "\(page)")
        ]
    }
    
    private let page: Int
    private let limit: Int
    
    init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }
}
