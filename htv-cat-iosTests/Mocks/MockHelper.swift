//
//  MockHelper.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import Foundation
@testable import htv_cat_ios

final class MockHelper {
    static let shared = MockHelper()
    
    private init() { }
    
    func loadJson(name: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: name, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        return nil
    }
    
    func generateBreeds(count: Int) -> [BreedModel] {
        let jsonData = loadJson(name: "breed_example")!
        let breed = try! SnakeCaseJSONDecoder().decode(BreedModel.self, from: jsonData)
        return .init(repeating: breed, count: count)
    }
}
