//
//  HTTPClientTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import Combine
@testable import htv_cat_ios

class HTTPClientTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testSuccessDataRequest() throws {
        let endpoint = BreedListEndpoint(page: 0, limit: 10)
        let urlRequest = try endpoint.asURLRequest()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: urlRequest.allHTTPHeaderFields)!
            return (response, "mocked data".data(using: .utf8))
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Success is expected")
        
        let sut = HTTPClient(urlSession: urlSession)
        sut.requestData(request: endpoint)
            .sink { result in
                switch result {
                case .failure(_):
                    XCTFail("Fail unexpected")
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testStatusCodeErrorDataRequest() throws {
        let endpoint = BreedListEndpoint(page: 0, limit: 10)
        let urlRequest = try endpoint.asURLRequest()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: urlRequest.url!, statusCode: 500, httpVersion: nil, headerFields: urlRequest.allHTTPHeaderFields)!
            return (response, Data())
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Error is expected")
        
        let sut = HTTPClient(urlSession: urlSession)
        sut.requestData(request: endpoint)
            .sink { result in
                switch result {
                case .failure(let error):
                    if case HTTPError.statusCode(_) = error {
                        expectation.fulfill()
                    }
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                XCTFail("Success unexpected")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testInvalidResponseErrorDataRequest() throws {
        let endpoint = BreedListEndpoint(page: 0, limit: 10)
        let urlRequest = try endpoint.asURLRequest()
        
        MockURLProtocol.requestHandler = { request in
            return (URLResponse(), Data())
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Error is expected")
        
        let sut = HTTPClient(urlSession: urlSession)
        sut.requestData(request: endpoint)
            .sink { result in
                switch result {
                case .failure(let error):
                    if case HTTPError.invalidResponse = error {
                        expectation.fulfill()
                    }
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                XCTFail("Success unexpected")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testUrlRequestErrorDataRequest() throws {
        let endpoint = InvalidEndpoint()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "whatever")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Error is expected")
        
        let sut = HTTPClient(urlSession: urlSession)
        sut.requestData(request: endpoint)
            .sink { result in
                switch result {
                case .failure(let error):
                    if case AppError.unknownError = error {
                        expectation.fulfill()
                    }
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                XCTFail("Success unexpected")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testSuccessObjectRequest() throws {
        let endpoint = BreedListEndpoint(page: 0, limit: 10)
        let urlRequest = try endpoint.asURLRequest()
        
        MockURLProtocol.requestHandler = { request in
            let mockedData = MockHelper.shared.loadJson(name: "image_search_endpoint_success")!
            let response = HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: urlRequest.allHTTPHeaderFields)!
            return (response, mockedData)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Success is expected")
        
        var breedImages: [BreedImageModel] = []
        
        let sut = HTTPClient(urlSession: urlSession)
        let publisher: AnyPublisher<[BreedImageModel], Error> = sut.requestObject(request: endpoint)
        publisher
            .sink { result in
                switch result {
                case .failure(_):
                    XCTFail("Fail unexpected")
                    break
                case .finished:
                    break
                }
            } receiveValue: { value in
                breedImages = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(breedImages.count, 1)
        XCTAssertEqual(breedImages[0].id, "itfFA4NWS")
        XCTAssertEqual(breedImages[0].url.absoluteString, "https://cdn2.thecatapi.com/images/itfFA4NWS.jpg")
        XCTAssertEqual(breedImages[0].width, 1280)
        XCTAssertEqual(breedImages[0].height, 914)
    }
    
    func testErrorObjectRequest() throws {
        let endpoint = BreedListEndpoint(page: 0, limit: 10)
        let urlRequest = try endpoint.asURLRequest()
        
        MockURLProtocol.requestHandler = { request in
            let mockedData = MockHelper.shared.loadJson(name: "empty_json")!
            let response = HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: urlRequest.allHTTPHeaderFields)!
            return (response, mockedData)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Error is expected")
                
        let sut = HTTPClient(urlSession: urlSession)
        let publisher: AnyPublisher<[BreedImageModel], Error> = sut.requestObject(request: endpoint)
        publisher
            .sink { result in
                switch result {
                case .failure(let error):
                    if case HTTPError.decodingError(_) = error {
                        expectation.fulfill()
                    }
                    break
                case .finished:
                    break
                }
            } receiveValue: { _ in
                XCTFail("Success unexpected")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
}

fileprivate class InvalidEndpoint: HTTPRequest {
    var method: HTTPMethod = .GET
    
    var path: String = "/invalid"
    
    func asURLRequest() throws -> URLRequest {
        throw AppError.unknownError
    }
}
