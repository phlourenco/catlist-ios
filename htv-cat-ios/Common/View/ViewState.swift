//
//  ViewState.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

typealias ErrorRetryFunction = () -> Void

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(Error, ErrorRetryFunction?)
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.empty, .empty):
            return true
        case (.error(let lhsError, _), .error(let rhsError, _)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

