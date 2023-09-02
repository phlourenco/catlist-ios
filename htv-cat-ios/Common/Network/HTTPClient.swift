//
//  HTTPClient.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation
import Combine

protocol IHTTPClient {
    func requestData(request: HTTPRequest) -> AnyPublisher<Data, Error>
    func requestObject<T: Decodable>(request: HTTPRequest) -> AnyPublisher<T, Error>
}

enum HTTPError: Error {
    case invalidUrl
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
}

enum HTTPMethod: String {
    case GET
    case POST
}

class HTTPClient: IHTTPClient {
    func requestData(request: HTTPRequest) -> AnyPublisher<Data, Error> {
        do {
            let urlRequest = try request.asURLRequest()
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .subscribe(on: DispatchQueue.global(qos: .default))
                .tryMap { (data: Data, response: URLResponse) in
                    guard let response = response as? HTTPURLResponse else {
                        throw HTTPError.invalidResponse
                    }
                    
                    guard (200..<300).contains(response.statusCode) else {
                        throw HTTPError.statusCode(response.statusCode)
                    }
                    
                    return data
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func requestObject<T>(request: HTTPRequest) -> AnyPublisher<T, Error> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return requestData(request: request)
            .tryMap { data in
                try decoder.decode(T.self, from: data)
            }
            .mapError { error in
                return HTTPError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
}
