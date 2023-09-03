//
//  HTTPClientMock.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import Foundation
import Combine
@testable import htv_cat_ios

final class HTTPClientMock: IHTTPClient {
    var error = false
    var dataToReturn: Data?
    var objectToReturn: Any?
    
    func requestData(request: HTTPRequest) -> AnyPublisher<Data, Error> {
        if error {
            return Fail(error: HTTPError.invalidUrl).eraseToAnyPublisher()
        }
        
        return Just(dataToReturn!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func requestObject<T>(request: HTTPRequest) -> AnyPublisher<T, Error> where T : Decodable {
        if error {
            return Fail(error: HTTPError.invalidUrl).eraseToAnyPublisher()
        }
        
        return Just(objectToReturn as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
