//
//  DetailViewControllerTests.swift
//  htv-cat-iosTests
//
//  Created by Paulo Lourenço on 3/9/23.
//

import XCTest
import SnapshotTesting
import Kingfisher
@testable import htv_cat_ios

final class DetailViewControllerTests: XCTestCase {
    let imageCache = ImageCache(name: "DetailViewControllerTests")
    
    override func setUp() {
        super.setUp()
        KingfisherManager.shared.defaultOptions = [
            .onlyFromCache,
            .targetCache(imageCache)
        ]
        
        let options : [KingfisherOptionsInfoItem] = [.targetCache(imageCache)]
        
        imageCache.store(
           KFCrossPlatformImage(named: "mock_cat")!,
           forKey:  "https://cdn2.thecatapi.com/images/itfFA4NWS.jpg",
           options: KingfisherParsedOptionsInfo(KingfisherOptionsInfo(options))
         )
    }
    
    func testLoadedState() {
        let mockRepository = BreedRepositoryMock()
        let breed = MockHelper.shared.generateBreeds(count: 1)[0]
        let viewModel = DetailViewModel(breed: breed, repository: mockRepository, scheduler: .immediate)
        
        let vc = DetailViewController(viewModel: viewModel)
        assertSnapshot(of: vc, as: .image)
    }
}
