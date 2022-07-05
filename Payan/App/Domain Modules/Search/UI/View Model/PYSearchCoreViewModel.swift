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
    @Published var showNoResultsWereFound = false
    private var cancellables = Set<AnyCancellable>()
    
    private let interactor: PYSearchCoreBusinessLogic
    
    init(interactor: PYSearchCoreInteractor) {
        self.interactor = interactor
        $searchText
            .removeDuplicates()
            .map { [weak self] text -> String in
                guard let self = self else { return text }
                if text.isEmpty {
                    self.results = []
                    self.showNoResultsWereFound = false
                }
                return text
            }
            .filter { $0.count > 2 }
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .map { [weak self] text -> String in
                guard let self = self else { return text }
                self.isLoading = true
                return text
            }
            .flatMap { [weak self] text in
                return (self?.interactor.search(text: text)
                            .catch { _ in Empty<[PYSearchResult], Never>() })!
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] res in
                guard let self = self else { return }
                self.isLoading = false
                self.showNoResultsWereFound = res.isEmpty
                self.results = res
            }
            .store(in: &cancellables)
    }
    
    func result(at index: Int) -> PYSearchResult {
        results[index]
    }
    
    func item(of result: PYSearchResult, at index: Int) -> PYSearchResultItem {
        result.items[index]
    }
}
