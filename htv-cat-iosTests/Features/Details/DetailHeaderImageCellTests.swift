//
//  DetailHeaderImageCellTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import SnapshotTesting
@testable import htv_cat_ios

class DetailHeaderImageCellTests: XCTestCase {
    func testCell() {
        let viewModel = DetailHeaderImageCellViewModel(breedImage: nil)
        let container = CollectionViewCellSnapshotContainer<DetailHeaderImageCell>(cellIdentifier: DetailHeaderImageCell.cellIdentifier, estimatedHeight: 300) { cell in
            cell.configure(viewModel: viewModel, delegate: nil)
        }
        
        assertSnapshot(matching: container, as: .image)
    }
}
