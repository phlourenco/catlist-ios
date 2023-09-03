//
//  DetailViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 2/9/23.
//

import Foundation
import Combine

final class DetailViewModel {
    
    // MARK: - Private properties
    
    private let repository: IBreedRepository
    private var cancellables = Set<AnyCancellable>()
    private(set) var breed: BreedModel
    @Published private(set) var state: ViewState = .idle
    @Published private(set) var sections: [ListSection] = []
    
    private(set) var backSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Constructor
    
    init(breed: BreedModel, repository: IBreedRepository = BreedRepository()) {
        self.breed = breed
        self.repository = repository
        
        sections = [
            DetailHeaderSection(breedImage: nil, delegate: self),
            DetailBodySection(breed: breed)
        ]
    }
    
    // MARK: - Public methods
    
    func getDetails() {
        state = .loading
        
        repository.fetchBreedImages(breedId: breed.id)
//            .delay(for: 2, scheduler: DispatchQueue.main) // TODO: Remove delay
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let retry: ErrorRetryFunction = { [weak self] in
                        self?.getDetails()
                    }
                    
                    self?.state = .error(error, retry)
                default:
                    break
                }
            } receiveValue: { [weak self] images in
                self?.handleResponse(images)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private methods
    
    private func handleResponse(_ images: [BreedImageModel]) {
        sections.removeAll(where: { $0 is DetailHeaderSection })
        sections.insert(DetailHeaderSection(breedImage: images.first, delegate: self), at: 0)
        state = .loaded(empty: images.isEmpty)
    }
}

extension DetailViewModel: DetailHeaderImageCellDelegate {
    func back() {
        backSubject.send(())
    }
}
