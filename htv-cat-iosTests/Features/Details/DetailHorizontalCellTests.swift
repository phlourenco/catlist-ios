//
//  DetailHorizontalCellTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import SnapshotTesting
@testable import htv_cat_ios

class DetailHorizontalCellTests: XCTestCase {
    func testCell() {
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let viewModel = DetailHorizontalCellViewModel(breed: breed)
        let container = CollectionViewCellSnapshotContainer<DetailHorizontalCell>(cellIdentifier: DetailHorizontalCell.cellIdentifier, estimatedHeight: 60) { cell in
            cell.configure(viewModel: viewModel, delegate: nil)
        }
        
        assertSnapshot(matching: container, as: .image)
    }
}
