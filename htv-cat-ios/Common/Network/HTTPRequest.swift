//
//  HTTPRequest.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

protocol HTTPRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    
    func asURLRequest() throws -> URLRequest
}

extension HTTPRequest {
    var parameters: [URLQueryItem] {
        return []
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseUrl = URL(string: Environment.apiUrl) else {
            throw HTTPError.invalidUrl
        }
        let urlWithPath = baseUrl.appendingPathComponent(path)
        
        var urlComponents = URLComponents(url: urlWithPath, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = parameters
        
        guard let fullUrl = urlComponents?.url else {
            throw HTTPError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(Environment.apiKey, forHTTPHeaderField: "x-api-key")
        
        if let headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        return urlRequest
    }
}
