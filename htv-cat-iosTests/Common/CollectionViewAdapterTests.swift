//
//  CollectionViewAdapterTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import Combine
@testable import htv_cat_ios

class CollectionViewAdapterTests: XCTestCase {
    func testDidSelectRow() {
        let spy = AdapterSpy()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        let sut = CollectionViewAdapter(sections: [MockSection()])
        sut.delegate = spy
        sut.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(spy.didSelectRowAtCount, 1)
        sut.collectionView(collectionView, didSelectItemAt: IndexPath(item: 2, section: 2))
        XCTAssertEqual(spy.didSelectRowAtCount, 2)
        XCTAssertEqual(spy.didSelectRowAtIndexPath, IndexPath(item: 2, section: 2))
    }
    
    func testWillDisplay() {
        let spy = AdapterSpy()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.contentOffset = .init(x: 0, y: 100)
        let sut = CollectionViewAdapter(sections: [MockSection()])
        sut.delegate = spy
        sut.collectionView(collectionView, willDisplay: UICollectionViewCell(), forItemAt: IndexPath(item: 2, section: 0))
        XCTAssertEqual(spy.willDisplayLastCellCount, 1)
    }
}

fileprivate class AdapterSpy: CollectionViewAdapterDelegate {
    var didSelectRowAtCount = 0
    var didSelectRowAtIndexPath: IndexPath?
    var willDisplayLastCellCount = 0
    
    func didSelectRowAt(indexPath: IndexPath) {
        didSelectRowAtCount += 1
        didSelectRowAtIndexPath = indexPath
    }
    
    func willDisplayLastCell() {
        willDisplayLastCellCount += 1
    }
}

fileprivate class MockSection: ListSection {
    func getNumberOfRows() -> Int {
        3
    }
    
    func getCellIdentifier(forRow row: Int) -> String {
        "MockCellIdentifier"
    }
    
    func getViewModel(forRow row: Int) -> CellViewModel? {
        nil
    }
}
