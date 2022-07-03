//
//  PYSearchCoreViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Combine
import Foundation

class PYSearchCoreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [PYSearchResult] = []
    @Published var isLoading = false
    private var cancellable: AnyCancellable? = nil
    
    private let interactor: PYSearchCoreBusinessLogic
    
    init(interactor: PYSearchCoreInteractor) {
        self.interactor = interactor
        cancellable = $searchText
            .removeDuplicates()
            .filter { $0.count > 2 }
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .map { text -> String in
                self.isLoading = true
                return text
            }
            .flatMap { text in
                return self.interactor.search(text: text)
                    .catch { _ in Empty<[PYSearchResult], Never>() }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] res in
                guard let self = self else { return }
                self.isLoading = false
                self.results = res
            }
    }
    
    func result(at index: Int) -> PYSearchResult {
        results[index]
    }
    
    func item(of result: PYSearchResult, at index: Int) -> PYSearchResultItem {
        result.items[index]
    }
}
