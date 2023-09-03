//
//  HomeViewModel.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 1/9/23.
//

import Foundation
import Combine
import CombineSchedulers

final class HomeViewModel {
    
    // MARK: - Private properties
    
    private let repository: IBreedRepository
    private let scheduler: AnySchedulerOf<DispatchQueue>
    private var cancellables = Set<AnyCancellable>()
    private var lastFetchedPage: Int?
    private let pageLimit = 10
    private(set) var breeds: [BreedModel] = []
    @Published private(set) var state: ViewState = .idle
    @Published private(set) var sections: [ListSection] = []

    // MARK: - Constructor
    
    init(
        repository: IBreedRepository = BreedRepository(),
        scheduler: AnySchedulerOf<DispatchQueue> = .main
    ) {
        self.repository = repository
        self.scheduler = scheduler
    }
    
    // MARK: - Public methods
    
    func getCatBreeds(nextPage: Bool = false) {
        guard state != .loading else { return }
        
        let pageToFetch = nextPage ? (breeds.count / pageLimit) : 0
        
        if nextPage, pageToFetch == lastFetchedPage {
            return
        }
        
        state = .loading
        repository.fetchBreeds(page: pageToFetch, limit: pageLimit)
            .receive(on: scheduler)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let retry: ErrorRetryFunction = { [weak self] in
                        self?.getCatBreeds(nextPage: nextPage)
                    }
                    
                    self?.state = .error(error, retry)
                default:
                    break
                }
            } receiveValue: { [weak self] breeds in
                self?.lastFetchedPage = pageToFetch
                self?.handleResponse(isFirstPage: !nextPage, breeds: breeds)
            }
            .store(in: &cancellables)

    }
    
    // MARK: - Private methods
    
    private func handleResponse(isFirstPage: Bool, breeds: [BreedModel]) {
        if isFirstPage {
            self.breeds = breeds
        } else {
            self.breeds.append(contentsOf: breeds)
        }
        sections = [BreedListSection(breeds: self.breeds)]
        state = .loaded(empty: self.breeds.isEmpty)
    }
}
