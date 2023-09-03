//
//  ListSection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

protocol ListSection {
    func getEstimatedHeight() -> CGFloat
    func getNumberOfRows() -> Int
    func getCellIdentifier(forRow row: Int) -> String
    func getViewModel(forRow row: Int) -> CellViewModel?
    func getDelegate(forRow row: Int) -> Any?
}

extension ListSection {
    func getDelegate(forRow row: Int) -> Any? {
        nil
    }
    
    func getEstimatedHeight() -> CGFloat {
        100
    }
}
