//
//  InfinityLoadingSection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation

final class InfinityLoadingSection: ListSection {
    func getNumberOfRows() -> Int {
        1
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        InfinityLoadingCell.cellIdentifier
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel? {
        nil
    }
}
