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
    case loaded(empty: Bool)
    case error(Error, ErrorRetryFunction?)
    case custom(any CustomViewState)
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded(let lhsEmpty), .loaded(let rhsEmpty)):
            return lhsEmpty == rhsEmpty
        case (.error(_, _), .error(_, _)):
            return true
        case (.custom(let lhsCustomState), .custom(let rhsCustomState)):
            return lhsCustomState.hashValue == rhsCustomState.hashValue
        default:
            return false
        }
    }
}

