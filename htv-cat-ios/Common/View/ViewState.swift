//
//  ViewState.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation

typealias ErrorRetryFunction = () -> Void
protocol CustomViewState: Hashable { }

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case error(Error, ErrorRetryFunction?)
    case custom(any CustomViewState)
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.error(_, _), .error(_, _)):
            return true
        case (.custom(let lhsCustomState), .custom(let rhsCustomState)):
            return lhsCustomState.hashValue == rhsCustomState.hashValue
        default:
            return false
        }
    }
}

