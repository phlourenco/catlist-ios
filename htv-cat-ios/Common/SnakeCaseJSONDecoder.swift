//
//  SnakeCaseJSONDecoder.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 3/9/23.
//

import Foundation

class SnakeCaseJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
