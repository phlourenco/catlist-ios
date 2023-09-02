//
//  ListSection.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import UIKit

protocol ListSection {
    func getNumberOfRows() -> Int
    func getCellIdentifier(forRow row: Int) -> String
    func getViewModel(forRow row: Int) -> CellViewModel?
    func getDelegate(forRow row: Int) -> Any?
}

extension ListSection {
    func getDelegate(forRow row: Int) -> Any? {
        return nil
    }
}
